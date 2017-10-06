app.addMenuItem({
	cName : "BookMark",
	cParent : "Help", //加在”帮助(Help)“菜单下面
	nPos : 0, //0为尽可能最顶，忽略则最底位置
	cExec : "makeBookmark();",
	cEnable : "event.rc= (event.target != null);" //当有文档打开时(event.target != null)才可用
});

function makeBookmark() {
	//提示导入目录
	if (!(this.importDataObject("txtBookmark"))) {
		return
	}
	//检验目录是否TXT文本格式
	var MyData = this.getDataObject("txtBookmark");
	if (MyData["MIMEType"] != "text/plain") {
		app.alert("附件不是TXT格式！");
		this.removeDataObject("txtBookmark");
		return
	}

	var FirstPageNum = app.response({
			cQuestion : "输入页码为1的实际页数",
			cTitle : "若缺少1页码，则输入2页码的实际页数，依此类推",
			cDefault : "2",
			cLabel : "输入:"
		});

	if (FirstPageNum != null) {
		var MyStream = this.getDataObjectContents("txtBookmark");
		var MyString = util.stringFromStream(MyStream, "utf-8");
		//替换全角空格
		MyString = MyString.replace(/　/g, " ");
		//处理前后空格
		MyString = MyString.replace(/^ \.*| $/gm, "");
		var myArr = MyString.split("\n");

		this.bookmarkRoot.remove();
		this.bookmarkRoot.createChild("目录");
		var Bkm = new Array(10); //创建一个数组来缓存书签
		Bkm[0] = this.bookmarkRoot.children[0];
		var HasPart = false; //设置一个flag表示是否遇到“部分”等没有.号的大分类
		for (var i in myArr) {
			f.value = "已处理：" + i + "/" + myArr.length;
			var myRow = myArr[i];
			if (myRow.length > 2) { //空行的length=1，设置为2即不处理空行
				var Num_Dot = 0;
				var BeforeSpace = myRow.match(/^(\d+\.)+\d\u0020/g); //1.2.3空格
				if (BeforeSpace != null) {
					var DotMatches = BeforeSpace.toString().match(/\./g); //匹配.符号
					Num_Dot = DotMatches.length + HasPart;
				} else {
					var myRegExp = /第.*[\d一二三四五六七八九十]+.*部分|附录|索引/;
					if (myRegExp.test(myRow)) {
						Num_Dot = 0;
						HasPart = true;
					} else {
						Num_Dot = HasPart + 0;
					}
				}

				var LastSpaceIndex = myRow.lastIndexOf("\u0020"); //最后一个空格的位置
				var Page = Number(myRow.slice(LastSpaceIndex));
				var Page_Bookmark = isNaN(Page) ? 0 : Page - 2 + Number(FirstPageNum); //书签指向的页码
				var Name_Bookmark = isNaN(Page) ? myRow : myRow.slice(0, LastSpaceIndex); //书签的名字

				with (Bkm[Num_Dot]) {
					createChild(Name_Bookmark, "this.pageNum=" + Page_Bookmark + ";", (children != null ? children.length : 0));
					Bkm[Num_Dot + 1] = children[children.length - 1]; //目录中最后一个章节
				}
			}
		}
		collapsBM(Bkm[0]);
	}
}

function collapsBM(BM) { //折叠所有书签
	if (BM.children != null) {
		if (BM != this.bookmarkRoot) {
			for (var i in BM.children) {
				if (BM.children[i].children != null) {
					BM.children[i].open = false;
				}
			}
		}
		for (var i in BM.children) {
			collapsBM(BM.children[i])
		}
	}
}
