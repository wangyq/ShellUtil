<?php
/* 
 *  微信/易信公众号测试器
 *  
 *  本脚本仿真微信/易信平台，对你的公众号指定的URL进行访问并显示响应信息值，用于开发和调试公众号
 *  
 *  JoStudio, 2013.10.10
 *  
 *  Web:  http://www.jostudio.org
 *  BLOG： http://blog.csdn.net/c80486
 *  
 */


//需要配置的数据: 公众号的TOKEN值，请改为你的公众号实际TOKEN值
//如果TOKEN值不配置，也可以运行，但签名值(signature)将不正确。
$token = "XXXXX";  //公众号的TOKEN值


////主程序开始
$url = "";         //公众号的URL
$text_content = "";  //文本内容
$menu_key = "";      //菜单值
$responseData = "";  //公众号URL的响应数据
$errmsg = "";  //错误信息
$isGbk = false; //返回数据是否GBK编码
$isGet = false; //是否以GET方式访问URL

if (isset($_POST['BUTTON'])) {//如果是POST方式提交的
   $url = $_POST['url'];      //取得表单中的URL
   $url = correctUrl($url);   //如果URL前没有http:// 或 https:// ，则加上
   $button = $_POST['BUTTON']; //是哪个按钮提交的
   $post_data = "";            //用于POST的数据
   if (isset($_POST['GBK']))  {
   		$GBK = $_POST['GBK'];      //表单中的数据是否GBK编码
   		if ($GBK=="true") $isGbk = true;
   }
   
	if (isset($_POST['IsGet']))  {
   		$s = $_POST['IsGet'];      //表单中的数据, 是否以GET方式访问URL
   		if ($s=="true") $isGet = true;
   }
   
   
   //对于不同的提交按钮，分别进行处理
   switch ($button) {
		case "发送文字消息":   
   			$text_content = $_POST['text_content'];  //取得文本内容
   			$post_data = getPostDataOfText($text_content);  //形成准备提交到公众号URL的文字消息数据
   			break;
		case "点击菜单":
			$menu_key = $_POST['menu_key'];
   		    $post_data = getPostDataOfClick($menu_key); //形成准备提交到公众号URL的菜单CLICK事件的消息数据
   		    break;
		case "从头开始": //从头开始，就是从关注公众号开始，即：发送subscibe消息到公众号URL
			$post_data = getPostDataOfSubscribe();  //形成准备提交到公众号URL的subscibe消息数据 
			break;
   }
   
	if ( (!empty($url)) && (!empty($post_data)) ) {
		if ($isGet) 
			$responseData=browseUrl($url); //以GET方式提交访问url
		else
   			$responseData=browseUrl($url.getQueryString(), $post_data); //向url以POST方式提交数据, 取得响应数据
	}
	 		
   	if (empty($url))
   		$responseData = "<h4><font color='red'>错误: 请输入公众号URL!!!</font><h4>";
}
////主程序结束


//函数：如果URL前没有http:// 或 https:// ，则加上
function correctUrl($url) {
	if  ( (strtolower(substr($url,0,strlen('http://'))) != 'http://')  
	      && (strtolower(substr($url,0,strlen('https://'))) != 'https://') )
		$url = 'http://'.$url;
		
	return $url;
}


//函数：返回向微信公众号URL查询时需要用到的QueryString(含签名值)
function getQueryString() {
	global $token;
	
	$timestamp = "".time();
	$nonce = "".rand(10000, 99999);	
	$tmpArr = array($token, $timestamp, $nonce);
	
	sort($tmpArr);
	$tmpStr = implode( $tmpArr );	
	$signature = sha1( $tmpStr );

	return "?timestamp=$timestamp&nonce=$nonce&signature=$signature";
}


//函数：返回subsribe事件的消息数据(xml格式)
function getPostDataOfSubscribe() {
	$str = '<xml>
			<ToUserName><![CDATA[toUser]]></ToUserName>
			<FromUserName><![CDATA[emulator_user]]></FromUserName>
			<CreateTime>'.time().'</CreateTime>
			<MsgType><![CDATA[event]]></MsgType>
			<Event><![CDATA[subscribe]]></Event>
			</xml>';
	return $str;	
}

//函数：返回文字消息的消息数据(xml格式)
function getPostDataOfText($content)
{
	$textTpl = "<xml>
                    <ToUserName><![CDATA[%s]]></ToUserName>
                    <FromUserName><![CDATA[%s]]></FromUserName>
                    <CreateTime>%s</CreateTime>
                    <MsgType><![CDATA[text]]></MsgType>
                    <Content><![CDATA[%s]]></Content>
                    <FuncFlag>%d</FuncFlag>
                    </xml>";
    $resultStr = sprintf($textTpl, 'user_to', 'emulator_user', time(), $content, 0);
    return $resultStr;
} 

//函数：返回菜单CLICK事件的消息数据(xml格式)
function getPostDataOfClick($content)
{
	$textTpl = "<xml>
                    <ToUserName><![CDATA[%s]]></ToUserName>
                    <FromUserName><![CDATA[%s]]></FromUserName>
                    <CreateTime>%s</CreateTime>
                    <MsgType><![CDATA[event]]></MsgType>
                    <Event><![CDATA[CLICK]]></Event>
                    <EventKey><![CDATA[%s]]></EventKey>
                    <FuncFlag>%d</FuncFlag>
                    </xml>";
    $resultStr = sprintf($textTpl, 'user_to', 'emulator_user', time(), $content, 0);
    return $resultStr;
} 


//函数：以POST方式访问URL，提交数据$data, 返回结果文本
//如果 $data为null, 则以GET方式访问URL
function browseUrl($url, $data=null) {

	$options = array(
	    'http' => array(
	        'header'  => "Content-type: raw/xml\r\n".
						 "User-Agent: Mozilla/5.0",
	        'method'  => 'POST',
	        'content' => $data,
	    ),
	);
	$context  = stream_context_create($options);
	// set to the user defined error handler
	$old_error_handler = set_error_handler("browseUrlErrorHandler");
	//post url using file_get_contents()
	
	
	if ($data==null)
		$result = file_get_contents($url); //以GET方式访问
	else
		$result = file_get_contents($url, false, $context); //以POST方式访问
	return $result;	
}

// error handler function
function browseUrlErrorHandler($errno, $errstr, $errfile, $errline)
{   global $errmsg;

	$errmsg  = "访问 URL出错，请检查URL是否正确!!!\r\n".$errstr;
	$errmsg  = "<h4><font color='red'>$errmsg</font><h4>";
}

// iconv handler function
function iconvErrorHandler($errno, $errstr, $errfile, $errline)
{   global $errmsg;
	$errmsg  = "转换编码出错:".$errstr;
}

//函数：判断$str是不是xml
function isXml($str) {
	$startStr = substr($str,0,20); 
	if (!strstr($startStr,'<xml>')) 
		return false;
	return true;
}
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<body>
<h1><strong>微信/易信公众号调试器</strong>&nbsp;</h1>
本脚本仿真微信/易信平台，对你的公众号指定的URL进行访问并显示响应信息值，用于开发和调试公众号。
<hr>
<form name="form1" method="post" action="">
<table>
  <tr>
	  <td>公众号URL :</td>
	  <td><input type="text" name="url" size=60 value="<?php echo $url?>"> </td>
	  <td><input type="submit" name="BUTTON" value="从头开始"></td>
  </tr>
  <tr>
	  <td>文字信息内容 ：</td>
	  <td><input type="text" name="text_content" size=60 value="<?php echo $text_content?>"></td>
	  <td><input type="submit" name="BUTTON" value="发送文字消息"></td>
  </tr>
  <tr>
     <td>菜单项EventKey值:</td>
	 <td><input type="text" name="menu_key" size=10 value="<?php echo $menu_key?>"></td>
  	 <td><input type="submit" name="BUTTON" value="点击菜单"></td>
  </tr>
  <tr>
     <td><br><input type="checkbox" name="GBK" value="true" <?php if ($isGbk) echo "checked"?>>返回数据是GBK编码</td>
  </tr>
  <tr>
     <td><input type="checkbox" name="IsGet" value="true" <?php if ($isGet) echo "checked"?>>以GET方式访问URL</td>
  </tr>
</table>
</form>
<?php    
   echo "<hr><h2> ".$url." 返回数据如下：</h2><hr>\r\n";

   if ($isGbk) {
   		restore_error_handler();
   		set_error_handler("iconvErrorHandler");
   		$s = iconv("gb2312", "utf-8", $responseData); //如果是gbk编码，则转换为utf-8编码
   		if (!empty($s)) $responseData = $s;
   }
   
   if (isXml($responseData)) //如果返回数据是xml
   		echo str_replace("\r\n","<br>\r\n",htmlspecialchars($responseData));
   else
   		echo $responseData; //返回数据不是xml，则直接显示(多是错误信息)
   		
   echo $errmsg;
?>