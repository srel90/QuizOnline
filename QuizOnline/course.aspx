<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="course.aspx.cs" Inherits="QuizOnline.course" %>
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
            $('#trainingType').kendoDropDownList();
            $("#kendoGrid").kendoGrid({
                dataSource: {
                    transport: {
                        read: function (options) {

                            $.ajax({
                                type: "POST",
                                url: "course.aspx/selectAllCourse",
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
                    { field: "ID", title: "ลำดับ", width: 60, type: "number" },
                    { field: "courseID", title: "รหัสหลักสูตร" },
                    { field: "courseName", title: "ชื่อหลักสูตร" },
                    { field: "instructor", title: "ผู้อบรม" },
                    { field: "trainingType", title: "ประเภทการอบรม" }
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

                $('#ID').val(selectedItem.ID);
                $('#courseID').val(selectedItem.courseID);
                $('#courseName').val(selectedItem.courseName);
                $('#instructor').val(selectedItem.instructor);
                $('#trainingType').data("kendoDropDownList").select(function (dataItem) {
                    return dataItem.value === $.trim(selectedItem.trainingType);
                });
            });
            $("#delete").click(function () {
                if ($("#delete").hasClass("k-state-disabled")) return;
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการลบ.'); return; }
                if (confirm('คุณต้องการลบรายการนี้หรือไม่?')) {
                    var response = $.parseJSON(ajax('course.aspx/delete', ({ ID: selectedItem.ID })));
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
            var lastID = $.parseJSON($.parseJSON(ajax('course.aspx/getLastID', ({}))).d).Table[0];
            $('#ID').val(lastID.lastID);
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
            <h2>จัดการข้อมูลหลักสูตร</h2>
          </div>
          <div class="module-content">
            <div class="custom">
              <form runat="server" id="scriptForm" action="course.aspx" method="post" name="scriptForm">
					<input id="mode" name="mode" type="hidden" value="insert" />
					<fieldset>
					<legend>รายการหลักสูตร</legend>
					<div id="kendoGrid">
					</div>
					</fieldset> <fieldset>
					<legend >ข้อมูลหลักสูตร</legend>
					<div>
						<div>
							<label>ลำดับ :</label>
							<input id="ID" class="input" name="ID" readonly="" title="คลิกปุ่มเพิ่มข้อมูลเพื่อสร้างรหัสใหม่" type="text"/>
							<span class="k-invalid-msg" data-for="ID">
							</span>
						</div>
                        <div>
							<label>รหัสหลักสูตร :</label>
							<input id="courseID" class="input" name="courseID" required="required" title="พิมพ์รหัสหลักสูตร" type="text"/>*
							<span class="k-invalid-msg" data-for="courseID"></span>
						</div>
						<div>
							<label>ชื่อหลักสูตร :</label>
							<input id="courseName" class="input" name="courseName" required="required" title="พิมพ์ชื่อหลักสูตร" type="text"/>*
							<span class="k-invalid-msg" data-for="courseName"></span>
						</div>
						<div>
							<label>ผู้อบรม :</label>
							<input id="instructor" class="input" name="instructor" required="required" title="พิมพ์ชื่อผู้อบรม" type="text"/>*
							<span class="k-invalid-msg" data-for="instructor"></span>
						</div>
                        <div>
							<label>ประเภทการอบรม :</label>
                            <select id="trainingType" name="trainingType" required="required" title="เลือกประเภทการอบรม">
                                <option value="">เลือกประเภทการอบรม</option>
                                <option value="InHouse">InHouse</option>
                                <option value="Public">Public</option>
                                <option value="OverSea">OverSea</option>
                                <option value="Other">Other</option>
                            </select>*
							<span class="k-invalid-msg" data-for="trainingType"></span>
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
