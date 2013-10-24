<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="QuizOnline.users" %>
<%@ Register TagPrefix="uc" TagName="uc1" Src="~/menu.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>QuizOnline System</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <link rel="stylesheet" href="css/menu.css" type="text/css" />
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.css" type="text/css" />
    <link rel="stylesheet" href="css/kendo.common.min.css" type="text/css" />
    <link rel="stylesheet" href="css/kendo.default.min.css" type="text/css" />
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
            $('#userTypeID').kendoDropDownList();
            $('#valueDate').kendoDatePicker({ format: "yyyy-MM-dd" });
            $('#dateOfBirth').kendoDatePicker({ format: "yyyy-MM-dd" });
            $("#kendoGrid").kendoGrid({
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
                $('#userID').val(selectedItem.userID);
                $('#userTypeID').data("kendoDropDownList").select(function (dataItem) {
                    return dataItem.value === selectedItem.userTypeID;
                });
                $('#IDCard').val(selectedItem.IDCard);
                $('#name').val(selectedItem.name);
                $('#lastname').val(selectedItem.lastname);
                $('#title').val(selectedItem.title);
                $('#username').val(selectedItem.username);
                $('#dateOfBirth').val(selectedItem.dateOfBirth);
                $('#valueDate').val(selectedItem.valueDate);
                $('#department').val(selectedItem.department);
                $('#position').val(selectedItem.position);
                $('#address').val(selectedItem.address);
                $('#district').val(selectedItem.district);
                $('#subDistrict').val(selectedItem.subDistrict);
                $('#province').val(selectedItem.province);
                $('#zip').val(selectedItem.zip);
                $('#mobile').val(selectedItem.mobile);
                $('#email').val(selectedItem.email);
                setRDOValue('status', selectedItem.status);
            });
            $("#delete").click(function () {
                if ($("#delete").hasClass("k-state-disabled")) return;
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการลบ.'); return; }
                if (confirm('คุณต้องการลบรายการนี้หรือไม่?')) {
                    var response = $.parseJSON(ajax('users.aspx/delete', ({ userID: selectedItem.userID })));
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
            validator = $('#scriptForm').kendoValidator({
                rules: {
                    requestIdCard: function (input) {
                        var ret = true;
                        if (input.is('#IDCard')) {
                            ret = input.val() != '';
                        }
                        return ret;
                    },
                    verifyIdCard: function (input) {
                        var ret = true;
                        if (input.is('#IDCard')) {
                            ret = chkIDCard(input.val());
                        }
                        return ret;
                    },
                    verifyPasswords: function (input) {
                        var ret = true;
                        if (input.is('#confirmPassword')) {
                            ret = input.val() === $('#password').val();
                        }
                        return ret;
                    }
                },
                messages: {
                    verifyIdCard: "รหัสประจำตัวประชาชนไม่ถูกต้อง",
                    requestIdCard: "พิมพ์รหัสประจำตัวประชาชน",
                    verifyPasswords: "ยืนยันรหัสผ่านไม่ตรงกัน"
                }
            }).data("kendoValidator"), status = $('#error');
        }//end validator
        this.clearform = function () {
            $("#kendoGrid").data("kendoGrid").clearSelection();
            $("#kendoGrid").data("kendoGrid").dataSource.read();
            $("#kendoGrid").data("kendoGrid").refresh();
            HTMLFormElement.prototype.reset.call($('#scriptForm')[0]);
            var lastID = $.parseJSON($.parseJSON(ajax('users.aspx/getLastID', ({}))).d).Table[0];
            $('#userID').val(lastID.lastID);
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
                        <div class="logo-block"><a href="#" id="logo"></a></div>
                    </div>
                    <div id="grid-menu">
                        <div class="menu-block">
                            <uc:uc1 id="menu" runat="server" />
                        </div>
                    </div>
                    <div id="welcome" class="block">
                        <p>
                            Welcome :  
              <asp:Label ID="lbname" runat="server" Text="Label"></asp:Label>
                            : <a href="logout.aspx" style="color: yellow;">Logout</a>
                        </p>
                    </div>
                </header>
                <!-- #header-->
                <div id="content">
                    <div class="block">
                        <div class="module-surround">
                            <div>
                                <h2>จัดการข้อมูลผู้ใช้</h2>
                            </div>
                            <div class="module-content">
                                <div class="custom">
                                    <form runat="server" id="scriptForm" action="users.aspx" method="post" name="scriptForm">
                                        <input id="mode" name="mode" type="hidden" value="insert" />
                                        <fieldset>
                                            <legend>รายการข้อมูลผู้ใช้</legend>
                                            <div id="kendoGrid">
                                            </div>
                                        </fieldset>
                                        <fieldset>
                                            <legend>ข้อมูลผู้ใช้</legend>
                                            <div>
                                                <label>ลำดับ :</label>
                                                <input id="userID" class="input" name="userID" readonly title="คลิกปุ่มเพิ่มข้อมูลเพื่อสร้างรหัสใหม่" type="text" />
                                                <span class="k-invalid-msg" data-for="userID"></span>
                                            </div>
                                            <div>
                                                <label>ประเภทผู้ใช้ :</label>
                                                <asp:DropDownList ID="userTypeID" runat="server" required title="เลือกประเภทผู้ใช้"></asp:DropDownList>*
							<span class="k-invalid-msg" data-for="userTypeID"></span>
                                            </div>
                                            <div>
                                                <label>รหัสประจำตัวประชาชน :</label>
                                                <input id="IDCard" class="input" name="IDCard" required type="text" />*
                                                    <span class="k-invalid-msg" data-for="IDCard"></span>
                                            </div>
                                            <div>
                                                <label>คำนำหน้า :</label>
                                                <input id="title" class="input" name="title" required title="พิมพ์คำนำหน้า" type="text" />*
							<span class="k-invalid-msg" data-for="title"></span>
                                            </div>
                                            <div>
                                                <label>ชื่อ :</label>
                                                <input id="name" class="input" name="name" required title="พิมพ์ชื่อ" type="text" />*
							<span class="k-invalid-msg" data-for="name"></span>
                                            </div>
                                            <div>
                                                <label>นามสกุล :</label>
                                                <input id="lastname" class="input" name="lastname" required title="พิมพ์นามสกุล" type="text" />*
							<span class="k-invalid-msg" data-for="lastname"></span>
                                            </div>
                                            <div>
                                                <label>วันเดือนปีเกิด :</label>
                                                <input id="dateOfBirth" name="dateOfBirth" required title="เลือกวันเดือนปีเกิด" />*
							<span class="k-invalid-msg" data-for="dateOfBirth"></span>
                                            </div>
                                            <div>
                                                <label>วันที่เริ่มงาน :</label>
                                                <input id="valueDate" name="valueDate" required title="เลือกวันเดือนปีที่เริ่มงาน" />*
							<span class="k-invalid-msg" data-for="valueDate"></span>
                                            </div>
                                            <div>
                                                <label>หน่วยงาน :</label>
                                                <input id="department" class="input" name="department" title="พิมพ์หน่วยงาน" type="text" />
                                                <span class="k-invalid-msg" data-for="department"></span>
                                            </div>
                                            <div>
                                                <label>ตำแหน่ง :</label>
                                                <input id="position" class="input" name="position" title="พิมพ์ตำแหน่ง" type="text" />
                                                <span class="k-invalid-msg" data-for="position"></span>
                                            </div>
                                            <div>
                                                <label>ที่อยู่ :</label>
                                                <textarea id="address" class="input" name="address" title="พิมพ์ที่อยู่" cols="20" rows="2"></textarea>
                                                <span class="k-invalid-msg" data-for="address"></span>
                                            </div>
                                            <div>
                                                <label>แขวง / ตำบล :</label>
                                                <input id="subDistrict" class="input" name="subDistrict" title="พิมพ์แขวง / ตำบล" type="text" />
                                                <span class="k-invalid-msg" data-for="subDistrict"></span>
                                            </div>
                                            <div>
                                                <label>เขต / อำเภอ :</label>
                                                <input id="district" class="input" name="district" title="พิมพ์เขต / อำเภอ" type="text" />
                                                <span class="k-invalid-msg" data-for="district"></span>
                                            </div>
                                            <div>
                                                <label>จังหวัด :</label>
                                                <input id="province" class="input" name="province" title="พิมพ์จังหวัด" type="text" />
                                                <span class="k-invalid-msg" data-for="province"></span>
                                            </div>
                                            <div>
                                                <label>รหัสไปรษณ๊ย์ :</label>
                                                <input id="zip" class="input" name="zip" title="พิมพ์รหัสไปรษณ๊ย์" type="text" />
                                                <span class="k-invalid-msg" data-for="zip"></span>
                                            </div>
                                            <div>
                                                <label>อีเมล์ :</label>
                                                <input id="email" class="input" data-email-msg="รูปแบบอีเมล์ไม่ถูกต้อง" name="email" type="email" validationmessage="พิมพ์อีเมล์" />
                                                <span class="k-invalid-msg" data-for="email"></span>
                                            </div>
                                            <div>
                                                <label>เบอร์โทรศัพท์ :</label>
                                                <input id="mobile" class="input" name="mobile" title="พิมพ์เบอร์โทรศัพท์" type="text" />
                                                <span class="k-invalid-msg" data-for="mobile"></span>
                                            </div>
                                            <div>
                                                <label>ชื่อผู้ใช้ :</label>
                                                <input id="username" class="input" name="username" required type="text" title="พิมพ์ชื่อผู้ใช้" />*
							<span class="k-invalid-msg" data-for="username"></span>
                                            </div>
                                            <div>
                                                <label>รหัสผ่าน :</label>
                                                <input id="password" class="input" name="password" required title="พิมพ์รหัสผ่าน" type="password" />*
							<span class="k-invalid-msg" data-for="password"></span>
                                            </div>
                                            <div>
                                                <label>ยืนยันรหัสผ่าน :</label>
                                                <input id="confirmPassword" class="input" name="confirmPassword" type="password" />
                                                <span class="k-invalid-msg" data-for="confirmPassword"></span>
                                            </div>


                                            <div>
                                                <label>สถานะ :</label>
                                                <input id="status0" name="status" title="Inctive" type="radio" value="0">ไม่ใช้งาน
							<input id="status1" checked="checked" name="status" title="Active" type="radio" value="1">ใช้งาน
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


