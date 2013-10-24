<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="announcement.aspx.cs" Inherits="QuizOnline.announcement" %>
<%@ Register TagPrefix="uc" TagName="uc1" Src="~/menu.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>QuizOnline System</title>
<link rel="stylesheet" href="css/style.css" type="text/css" />
<link rel="stylesheet" href="css/menu.css" type="text/css"  />
<link rel="stylesheet" href="css/jquery.mCustomScrollbar.css"  type="text/css"/>
<link rel="stylesheet" href="css/kendo.common.min.css"  type="text/css"/>
<link rel="stylesheet" href="css/kendo.default.min.css"  type="text/css"/>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.mCustomScrollbar.js"></script>
<script type="text/javascript" src="js/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="js/boxOver.js"></script>
<script type="text/javascript" src="js/utility.js"></script>
<!--Kendo UI-->
<script type="text/javascript" src="js/kendo/kendo.all.min.js"></script>
<!--ENDS Kendo UI-->
<!--JQUERY FORM-->
<script src="js/jquery.form.min.js" type="text/javascript"></script>
<!--ENDS JQUERY FORM-->
<script type="text/javascript">
<!--
    $(function () {
        script.initial();
        script.validation();
        script.eventhandle();
        script.clearform();
    });
    var script = new function () {
        var validator = $("#scriptForm");
        var status = $('#error');
        this.initial = function () {
            $("#txtannouncement").kendoEditor({
                tools: [
                    "bold",
                    "italic",
                    "underline",
                    "strikethrough",
                    "justifyLeft",
                    "justifyCenter",
                    "justifyRight",
                    "justifyFull",
                    "insertUnorderedList",
                    "insertOrderedList",
                    "indent",
                    "outdent",
                    "createLink",
                    "unlink",
                    "insertImage",
                    "subscript",
                    "superscript",
                    "createTable",
                    "addRowAbove",
                    "addRowBelow",
                    "addColumnLeft",
                    "addColumnRight",
                    "deleteRow",
                    "deleteColumn",
                    "viewHtml",
                    "formatting",
                    "fontName",
                    "fontSize",
                    "foreColor",
                    "backColor"
                ]
            });
        }//end initial
        this.eventhandle = function () {
            $("#save").click(function () {
                if (validator.validate()) {
                    status.hide();
                    $('#loading').show();
                    var options = {
                        success: function (response) {
                            $('#loading').hide();
                            if ($.trim(response) == 'true') {
                                alert("ดำเนินการเรียบร้อย.");
                                script.clearform();
                            } else {
                                alert("ไม่สามารถดำเนินการได้!");
                            }
                        }
                    };
                    $("#scriptForm").ajaxSubmit(options);
                } else {
                    status.html("มีบางรายการป้อนข้อมูลไม่ถูกต้อง.").show();
                }
            });
        }//end eventhandle
        this.validation = function () {
            validator = $('#scriptForm').kendoValidator().data("kendoValidator"), status = $('#error');
        }//end validator
        this.clearform = function () {
            HTMLFormElement.prototype.reset.call($('#scriptForm')[0]);
        }//end clearForm

    }
    //-->
</script>

</head>
<body>
<div class="rt-bg">
<div class="rt-bg2">
  <div id="wrapper">
    <header id="header">
      <div id="grid-logo">
        <div class="logo-block"> <a href="#" id="logo"></a></div>
      </div>
      <div id="grid-menu">
        <div class="menu-block">
          <uc:uc1 id="menu" runat="server" />
        </div>
      </div>
        <div id="welcome" class="block">
          <p>Welcome :  
              <asp:Label ID="lbname" runat="server" Text="Label"></asp:Label>
              : <a href="logout.aspx" style="color:yellow;">Logout</a>
          </p>
        </div>
    </header>
    <!-- #header-->
    <div id="content">
      <div class="block">
        <div class="module-surround">
          <div >
            <h2>Announcement</h2>
          </div>
          <div class="module-content">
            <div class="custom">
              <form runat="server" id="scriptForm" action="announcement.aspx" method="post" name="scriptForm">
					<fieldset>
					<legend >จัดการข้อความประกาศ</legend>
					<div>
						<div>
							<label>ข้อความประกาศ :</label>

							<textarea runat="server" id="txtannouncement" name="txtannouncement" cols="20" rows="2" title="พิมพ์ข้อความประกาศ" ></textarea>
						</div>
					</div>
					<div class="clear" style="height: 10px">
					</div>
					<input id="save" class="k-button" name="save" type="button" value="บันทึก" />
					<img id="loading" alt="" src="images/loading.gif" style="vertical-align: middle; display: none;">
					</fieldset>
              </form>
            </div>
          </div>
        </div>
        <div class="clear"></div>
      </div>
      <!-- #content--> 
    </div>
    <!-- #wrapper -->
    <footer class="footer">
      <!--#include file="footer.html"-->
    </footer>
    <!-- #footer --> 
  </div>
</div>
</div>
</body>

</html>
