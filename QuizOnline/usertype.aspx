<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="usertype.aspx.cs" Inherits="QuizOnline.usertype" %>
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
            $('#error').hide();
            $("#kendoGrid").kendoGrid({
                dataSource: {
                    transport: {
                        read: function (options) {
                            
                            $.ajax({
                                type: "POST",
                                url: "usertype.aspx/selectAllUserType",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                autoSync: true,
                                success: function (msg) {
                                        options.success($.parseJSON(msg.d));
                                }
                            });
                        }
                    },
                    pageSize: 5,
                    schema: {
                        data: "Table",
                        total: "total"
                    }
                },
                filterable: true,
                resizable: true,
                reorderable: true,
                /*groupable: true,*/
                sortable: true,
                columnMenu: true,
                selectable: "multiple",
                pageable: { pageSizes: true },
                columns: [
                    { field: "userTypeID", title: "ลำดับ", width: 60, type: "number" },
                    { field: "userType", title: "ประเภทผู้ใช้" },
                    { field: "status", title: "สถานะ", template: '#=status==1?"ใช้งาน":"ไม่ใช้งาน"#' }
                ],
                toolbar: [
                    {
                        template: '<a class="k-button" href="javascript:;" id="addNew"><img src="images/mono-icons/doc_plus.png" width="12px">เพื่ม</a>'
                    },
                    {
                        template: '<a class="k-button" href="javascript:;" id="edit"><img src="images/mono-icons/doc_edit.png" width="12px">แก้ไข</a>'
                    },
                    {
                        template: '<a class="k-button" href="javascript:;" id="delete"><img src="images/mono-icons/doc_delete.png" width="12px">ลบ</a>'
                    },
                    {
                        template: '<a class="k-button" href="javascript:;" id="cancel"><img src="images/mono-icons/undo.png" width="12px">ยกเลิก</a>'
                    }

                ]
            });

        }//end initial
        this.eventhandle = function () {
            $("#addNew").click(function () {
                if ($("#addNew").hasClass("k-state-disabled")) return;
                $("#addNew").addClass("k-state-disabled");
                $("#edit").addClass("k-state-disabled");
                $("#delete").addClass("k-state-disabled");
                script.clearform();
                $('#mode').val('insert');

            });
            $("#edit").click(function () {
                if ($("#edit").hasClass("k-state-disabled")) return;
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการแก้ไข.'); return; }
                $("#addNew").addClass("k-state-disabled");
                $("#edit").addClass("k-state-disabled");
                $("#delete").addClass("k-state-disabled");
                $('#mode').val('update');

                $('#userTypeID').val(selectedItem.userTypeID);
                $('#userType').val(selectedItem.userType);
                setRDOValue('status', selectedItem.status);
            });
            $("#delete").click(function () {
                if ($("#delete").hasClass("k-state-disabled")) return;
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการลบ.'); return; }
                if (confirm('คุณต้องการลบรายการนี้หรือไม่?')) {
                    var response = $.parseJSON(ajax('usertype.aspx/delete', ({ userTypeID: selectedItem.userTypeID })));
                    if ($.trim(response.d) == 'true') {
                        script.clearform();
                    }
                }
            });
            $("#cancel").click(function () {
                $("#addNew").removeClass("k-state-disabled");
                $("#edit").removeClass("k-state-disabled");
                $("#delete").removeClass("k-state-disabled");
                script.clearform();
            });

            $("#save").click(function () {
                $("#addNew").removeClass("k-state-disabled");
                $("#edit").removeClass("k-state-disabled");
                $("#delete").removeClass("k-state-disabled");

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
            $("#kendoGrid").data("kendoGrid").clearSelection();
            $("#kendoGrid").data("kendoGrid").dataSource.read();
            $("#kendoGrid").data("kendoGrid").refresh();
            HTMLFormElement.prototype.reset.call($('#scriptForm')[0]);
            var lastID = $.parseJSON($.parseJSON(ajax('usertype.aspx/getLastID', ({}))).d).Table[0];
            $('#userTypeID').val(lastID.lastID);
            $('#mode').val('insert');
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
            <h2>จัดการข้อมูลประเภทผู้ใช้</h2>
          </div>
          <div class="module-content">
            <div class="custom">
              <form runat="server" id="scriptForm" action="usertype.aspx" method="post" name="scriptForm">
					<input id="mode" name="mode" type="hidden" value="insert" />
					<fieldset>
					<legend>รายการประเภทผู้ใช้</legend>
					<div id="kendoGrid">
					</div>
					</fieldset> <fieldset>
					<legend >ข้อมูลประเภทผู้ใช้</legend>
					<div>
						<div>
							<label>ลำดับ :</label>
							<input id="userTypeID" class="input" name="userTypeID" readonly title="คลิกปุ่มเพิ่มข้อมูลเพื่อสร้างรหัสใหม่" type="text">
							<span class="k-invalid-msg" data-for="userTypeID">
							</span></div>
						<div>
							<label>ประเภทผู้ใช้ :</label>
							<input id="userType" class="input" name="userType" required title="พิมพ์ประเภทผู้ใช้" type="text">*
							<span class="k-invalid-msg" data-for="userType"></span>
						</div>
						<div>
							<label>สถานะ :</label>
							<input id="status0" name="status" title="Inctive" type="radio" value="0">ไม่ใช้งาน
							<input id="status1" checked="checked" name="status" title="Active" type="radio" value="1">ใช้งาน
						</div>
					</div>
					<div class="clear" style="height: 10px">
					</div>
					<input id="save" class="k-button" name="save" type="button" value="บันทึก" />
					<img id="loading" alt="" src="images/loading.gif" style="vertical-align: middle; display: none;">
					<p id="error" class="warning">Message</p>
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
