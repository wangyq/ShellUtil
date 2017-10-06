app.addMenuItem({
	cName : "BookMark",
	cParent : "Help", //���ڡ�����(Help)���˵�����
	nPos : 0, //0Ϊ������������������λ��
	cExec : "makeBookmark();",
	cEnable : "event.rc= (event.target != null);" //�����ĵ���ʱ(event.target != null)�ſ���
});

function makeBookmark() {
	//��ʾ����Ŀ¼
	if (!(this.importDataObject("txtBookmark"))) {
		return
	}
	//����Ŀ¼�Ƿ�TXT�ı���ʽ
	var MyData = this.getDataObject("txtBookmark");
	if (MyData["MIMEType"] != "text/plain") {
		app.alert("��������TXT��ʽ��");
		this.removeDataObject("txtBookmark");
		return
	}

	var FirstPageNum = app.response({
			cQuestion : "����ҳ��Ϊ1��ʵ��ҳ��",
			cTitle : "��ȱ��1ҳ�룬������2ҳ���ʵ��ҳ������������",
			cDefault : "2",
			cLabel : "����:"
		});

	if (FirstPageNum != null) {
		var MyStream = this.getDataObjectContents("txtBookmark");
		var MyString = util.stringFromStream(MyStream, "utf-8");
		//�滻ȫ�ǿո�
		MyString = MyString.replace(/��/g, " ");
		//����ǰ��ո�
		MyString = MyString.replace(/^ \.*| $/gm, "");
		var myArr = MyString.split("\n");

		this.bookmarkRoot.remove();
		this.bookmarkRoot.createChild("Ŀ¼");
		var Bkm = new Array(10); //����һ��������������ǩ
		Bkm[0] = this.bookmarkRoot.children[0];
		var HasPart = false; //����һ��flag��ʾ�Ƿ����������֡���û��.�ŵĴ����
		for (var i in myArr) {
			f.value = "�Ѵ���" + i + "/" + myArr.length;
			var myRow = myArr[i];
			if (myRow.length > 2) { //���е�length=1������Ϊ2�����������
				var Num_Dot = 0;
				var BeforeSpace = myRow.match(/^(\d+\.)+\d\u0020/g); //1.2.3�ո�
				if (BeforeSpace != null) {
					var DotMatches = BeforeSpace.toString().match(/\./g); //ƥ��.����
					Num_Dot = DotMatches.length + HasPart;
				} else {
					var myRegExp = /��.*[\dһ�����������߰˾�ʮ]+.*����|��¼|����/;
					if (myRegExp.test(myRow)) {
						Num_Dot = 0;
						HasPart = true;
					} else {
						Num_Dot = HasPart + 0;
					}
				}

				var LastSpaceIndex = myRow.lastIndexOf("\u0020"); //���һ���ո��λ��
				var Page = Number(myRow.slice(LastSpaceIndex));
				var Page_Bookmark = isNaN(Page) ? 0 : Page - 2 + Number(FirstPageNum); //��ǩָ���ҳ��
				var Name_Bookmark = isNaN(Page) ? myRow : myRow.slice(0, LastSpaceIndex); //��ǩ������

				with (Bkm[Num_Dot]) {
					createChild(Name_Bookmark, "this.pageNum=" + Page_Bookmark + ";", (children != null ? children.length : 0));
					Bkm[Num_Dot + 1] = children[children.length - 1]; //Ŀ¼�����һ���½�
				}
			}
		}
		collapsBM(Bkm[0]);
	}
}

function collapsBM(BM) { //�۵�������ǩ
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
