<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="training.aspx.cs" Inherits="QuizOnline.training" %>
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
        var formAddUser;
        this.initial = function () {
            $('#error').hide();
            $('#trainingType').kendoDropDownList();
            $("#cost").kendoNumericTextBox({ format: "#.00" });
            $("#generation").kendoNumericTextBox({ format: "#" });           
            $('#valueDate').kendoDatePicker({ format: "yyyy-MM-dd" });
            var autocomplete = $("#courseID").kendoAutoComplete({
                minLength: 1,
                dataTextField: "courseID",
                template: '${ data.courseID }' + ' ${ data.courseName }',
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
                height: 370,
            }).data("kendoAutoComplete");
            formAddUser = $("#formAddUser");
            if (!formAddUser.data("kendoWindow")) {
                formAddUser.kendoWindow({
                    width: "800px",
                    height: "300px",
                    title: "Select User",
                    modal: true,
                    animation: false,
                    visible: false
                });
            }            
            $("#gridTableUser").kendoGrid({
                dataSource: {
                    transport: {
                        read: function (options) {

                            $.ajax({
                                type: "POST",
                                url: "users.aspx/selectAllUsers",
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
                    { field: "userID", title: "ลำดับ", width: 60, type: "number" },
                    { field: "IDCard", title: "รหัสประจำตัวประชาชน" },
                    { field: "title", title: "คำนำหน้า" },
                    { field: "name", title: "ชื่อ" },
                    { field: "lastname", title: "นามสกุล" },
                    { field: "username", title: "ชื่อผู้ใช้" },
                    { field: "userType", title: "ประเภทผู้ใช้" },
                    { field: "email", title: "อีเมล์" },
                    { field: "status", title: "สถานะ", template: '#=status==1?"ใช้งาน":"ไม่ใช้งาน"#' }
                ],
                toolbar: [
                    {
                        template: '<a class="k-button" href="javascript:;" id="btnSelect"><img src="images/mono-icons/doc_plus.png" width="12px">เลือกรายการ</a>'
                    }

                ]
            });
            $("#kendoGrid").kendoGrid({
                dataSource: {
                    transport: {
                        read: function (options) {

                            $.ajax({
                                type: "POST",
                                url: "training.aspx/selectAllTraining",
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
                    { field: "trainingRegisterID", title: "รหัสการลงทะเบียนอบรม", width: 60, type: "number" },
                    { field: "userID", title: "รหัสผู้ใช้ที่ต้องอบรม" },
                    { field: "valueDate", title: "วันที่อบรม" },
                    { field: "trainingType", title: "ประเภทการอบรม" },
                    { field: "courseID", title: "รหัสหลักสูตร" },
                    { field: "generation", title: "รุ่น" },
                    { field: "location", title: "สถานที่" },
                    { field: "cost", title: "ค่าใช้จ่าย" }
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
            $("#btnUser").click(function () {
                formAddUser.data("kendoWindow").center().open();
            });
            $("#btnSelect").click(function () {
                var gridTable = $("#gridTableUser").data("kendoGrid");
                var selectedItem = gridTable.dataItem(gridTable.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการ.'); return; }
                $('#userID').val(selectedItem.userID);
                $('#user').val(selectedItem.name + ' ' + selectedItem.lastname);
                formAddUser.data("kendoWindow").center().close();
            });
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

                $('#trainingRegisterID').val(selectedItem.trainingRegisterID);
                
                var user = ajax('users.aspx/selectUsersByUserID', ({ userID: selectedItem.userID }));
                user = $.parseJSON($.parseJSON(user).d);
              
                $('#user').val(user.Table[0].name + ' ' + user.Table[0].lastname);
                $('#userID').val(selectedItem.userID);
                $('#valueDate').val(selectedItem.valueDate);
                $('#trainingType').data("kendoDropDownList").select(function (dataItem) {
                    return dataItem.value === $.trim(selectedItem.trainingType);
                });
                $('#courseID').val(selectedItem.courseID);
                $('#generation').data("kendoNumericTextBox").value(selectedItem.generation);
                $('#location').val(selectedItem.location);
                $('#cost').data("kendoNumericTextBox").value(selectedItem.cost);
                
            });
            $("#delete").click(function () {
                if ($("#delete").hasClass("k-state-disabled")) return;
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการลบ.'); return; }
                if (confirm('คุณต้องการลบรายการนี้หรือไม่?')) {
                    var response = $.parseJSON(ajax('training.aspx/delete', ({ trainingRegisterID: selectedItem.trainingRegisterID })));
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
            var lastID = $.parseJSON($.parseJSON(ajax('training.aspx/getLastID', ({}))).d).Table[0];
            $('#trainingRegisterID').val(lastID.lastID);
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
            <h2>จัดการข้อมูลการฝึกอบรม</h2>
          </div>
          <div class="module-content">
            <div class="custom">
              <form runat="server" id="scriptForm" action="training.aspx" method="post" name="scriptForm">
					<input id="mode" name="mode" type="hidden" value="insert" />
					<fieldset>
					<legend>รายการผู้เข้ารับการอบรม</legend>
					<div id="kendoGrid">
					</div>
					</fieldset> <fieldset>
					<legend >ข้อมูลการเข้ารับการอบรม</legend>
					<div>
						<div>
							<label>รหัสการลงทะเบียนอบรม :</label>
							<input id="trainingRegisterID" class="input" name="trainingRegisterID" readonly="" title="คลิกปุ่มเพิ่มข้อมูลเพื่อสร้างรหัสใหม่" type="text"/>
							<span class="k-invalid-msg" data-for="trainingRegisterID">
							</span>
						</div>
                        <div>
							<label>ผู้ใช้ที่ต้องอบรม :</label>
							<input id="user" class="input" name="user" required="required" type="text" style="width:144px" readonly=""/>
                            <input id="userID" class="input" name="userID"  title="พิมพ์รหัสผู้ใช้ที่ต้องอบรม" type="hidden" />
							<a href="javascript:;" id="btnUser"><img src="images/mono-icons/zoom.png" width="16" style="vertical-align: middle;" /></a>*
                            <span class="k-invalid-msg" data-for="userID"></span>
						</div>
						<div>
							<label>วันที่อบรม :</label>
							<input id="valueDate" class="input" name="valueDate" required="required" title="เลือกวันที่อบรม" type="text"/>*
							<span class="k-invalid-msg" data-for="valueDate"></span>
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
                        <div>
							<label>รหัสหลักสูตร :</label>
							<input id="courseID" class="input" name="courseID" required="required" title="พิมพ์รหัสหลักสูตร" type="text"/>*
							<span class="k-invalid-msg" data-for="courseID"></span>
						</div>
                        <div>
							<label>รุ่น :</label>
							<input id="generation" class="input" name="generation" required="required" title="พิมพ์รุ่น" type="text"/>*
							<span class="k-invalid-msg" data-for="generation"></span>
						</div>
                        <div>
							<label>สถานที่ :</label>
							<input id="location" class="input" name="location" required="required" title="พิมพ์สถานที่" type="text"/>*
							<span class="k-invalid-msg" data-for="location"></span>
						</div>
                        <div>
							<label>ค่าใช้จ่าย :</label>
							<input id="cost" class="input" name="cost" required="required" title="พิมพ์ค่าใช้จ่าย" type="text"/>*
							<span class="k-invalid-msg" data-for="cost"></span>
						</div>
					</div>
					<div class="clear" style="height: 10px">
					</div>
					<input id="save" class="k-button" name="save" type="button" value="บันทึก" />
					<img id="loading" alt="" src="images/loading.gif" style="vertical-align: middle; display: none;"/>
					<p id="error" class="warning">Message</p>
					</fieldset>
                  <div id="formAddUser">
							<div id="gridTableUser"></div>
						</div>

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
