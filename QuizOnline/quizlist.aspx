<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="quizlist.aspx.cs" Inherits="QuizOnline.quizlist" %>
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
        var quizvalidator = $("#formQuiz");
        var status = $('#error');
        var formQuiz;
        this.initial = function () {
            $('#dateTimeFrom').kendoDatePicker({ format: "yyyy-MM-dd" });
            $('#dateTimeTo').kendoDatePicker({ format: "yyyy-MM-dd" });
            $('#description').kendoEditor();           
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
            $('#question').kendoEditor({
                tools: [         "bold",
                                "italic",
                                "underline",
                                "strikethrough",
                                "justifyLeft",
                                "justifyCenter",
                                "justifyRight",
                                "justifyFull",
                                "createLink",
                                "unlink",
                                "insertImage",
                                "createTable",
                                "addColumnLeft",
                                "addColumnRight",
                                "addRowAbove",
                                "addRowBelow",
                                "deleteRow",
                                "deleteColumn",
                                "foreColor",
                                "backColor"]
            });
            $('#numberQuiz').kendoNumericTextBox();
            $('#error').hide();
            $("#kendoGrid").kendoGrid({
                dataSource: {
                    transport: {
                        read: function (options) {

                            $.ajax({
                                type: "POST",
                                url: "quizlist.aspx/selectAllQuizList",
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
                groupable: true,
                sortable: true,
                columnMenu: true,
                selectable: "multiple",
                pageable: { pageSizes: true },
                columns: [
                    { field: "quizListID", title: "ลำดับ", width: 60, type: "number" },
                    { field: "title", title: "ชื่อข้อสอบ" },
                    { field: "valueDate", title: "วันที่ออกข้อสอบ" },
                    { field: "dateTimeFrom", title: "วันที่เริ่มให้ทำข้อสอบ" },
                    { field: "dateTimeTo", title: "วันที่สิ้นสุดให้ทำข้อสอบ" },
                    { field: "quizNumber", title: "ชุดที่", width: 60, type: "number" },
                    { field: "numberQuiz", title: "จำนวนข้อสอบ", width: 80, type: "number" },
                    { field: "user", title: "ผู้ออกข้อสอบ" },
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
            $("#quizGrid").kendoGrid({
                dataSource: {
                    transport: {
                        read: function (options) {

                            $.ajax({
                                type: "POST",
                                url: "quizlist.aspx/getSessionQuiz",
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
                    
                    { field: "question", title: "คำถาม" },
                    { field: "choice1", title: "ตัวเลือกที่ 1" },
                    { field: "choice2", title: "ตัวเลือกที่ 2" },
                    { field: "choice3", title: "ตัวเลือกที่ 3" },
                    { field: "choice4", title: "ตัวเลือกที่ 4" },
                    { field: "answer", title: "ตัวเลือกที่ถูกต้อง" },
                    { field: "status", title: "สถานะ", template: '#=status==1?"ใช้งาน":"ไม่ใช้งาน"#' }
                ],
                toolbar: [
                    {
                        template: '<a class="k-button" href="javascript:;" id="addNewQuiz"><img src="images/mono-icons/doc_plus.png" width="12px">เพื่มข้อคำถาม</a>'
                    },
                    {
                        template: '<a class="k-button" href="javascript:;" id="editQuiz"><img src="images/mono-icons/doc_edit.png" width="12px">แก้ไข</a>'
                    },
                    {
                        template: '<a class="k-button" href="javascript:;" id="deleteQuiz"><img src="images/mono-icons/doc_delete.png" width="12px">ลบ</a>'
                    }

                ]
            });

            formQuiz = $("#formQuiz");
            if (!formQuiz.data("kendoWindow")) {
                formQuiz.kendoWindow({
                    width: "800px",
                    height: "500px",
                    title: "เพื่อข้อคำถาม",
                    modal: true,
                    animation: false,
                    visible: false
                });
            }

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

                $('#quizListID').val(selectedItem.quizListID);
                $('#title').val(selectedItem.title);
                $("#description").data("kendoEditor").value(selectedItem.description);
                $('#dateTimeFrom').val(selectedItem.dateTimeFrom);
                $('#dateTimeTo').val(selectedItem.dateTimeTo);
                $('#quizNumber').val(selectedItem.quizNumber);
                $('#numberQuiz').data("kendoNumericTextBox").value(selectedItem.numberQuiz);
                setRDOValue('status', selectedItem.status);
                $('#courseID').val(selectedItem.courseID);
                $('#location').val(selectedItem.location);
                ajax("quizlist.aspx/setSessionQuiz", ({ quizListID: selectedItem.quizListID }));
                $("#quizGrid").data("kendoGrid").dataSource.read();
            });
            $("#delete").click(function () {
                if ($("#delete").hasClass("k-state-disabled")) return;
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการลบ.'); return; }
                if (confirm('คุณต้องการลบรายการนี้หรือไม่?')) {
                    var response = $.parseJSON(ajax('quizlist.aspx/deleteQuizList', ({ quizListID: selectedItem.quizListID })));
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
            $('#addNewQuiz').click(function () {
                $('#quizmode').val("insertQuiz");
                formQuiz.data("kendoWindow").center().open();
            });
            $('#editQuiz').click(function () {
                var quizGrid = $("#quizGrid").data("kendoGrid");
                var selectedItem = quizGrid.dataItem(quizGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการแก้ไข.'); return; }
                $('#quizuid').val(selectedItem.quizuid);
                $("#question").data("kendoEditor").value(selectedItem.question);
                $('#choice1').val(selectedItem.choice1);
                $('#choice2').val(selectedItem.choice2);
                $('#choice3').val(selectedItem.choice3);
                $('#choice4').val(selectedItem.choice4);
                setRDOValue("answer", selectedItem.answer);
                setRDOValue("quizStatus", selectedItem.status);
                $('#quizmode').val("updateQuiz");
                formQuiz.data("kendoWindow").center().open();
            });
            $('#deleteQuiz').click(function () {
                var quizGrid = $("#quizGrid").data("kendoGrid");
                var selectedItem = quizGrid.dataItem(quizGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการลบ.'); return; }
                if (confirm('คุณต้องการลบรายการนี้หรือไม่?')) {
                    var response = $.parseJSON(ajax('quizlist.aspx/deleteQuiz', ({ quizuid: selectedItem.quizuid })));
                    if ($.trim(response.d) == 'true') {
                        $("#quizGrid").data("kendoGrid").dataSource.read();                       
                        $("#question").data("kendoEditor").value("");
                        $('#choice1').val("");
                        $('#choice2').val("");
                        $('#choice3').val("");
                        $('#choice4').val("");
                        setRDOValue("answer", 1);
                        setRDOValue("quizStatus", 1);
                    }
                }
            });
            $('#saveQuiz').click(function () {
                if (quizvalidator.validate()) {
                    var data = new Object();
                    data.question = $('#question').val();
                    data.choice1 = $('#choice1').val();
                    data.choice2 = $('#choice2').val();
                    data.choice3 = $('#choice3').val();
                    data.choice4 = $('#choice4').val();
                    data.answer = getRDOValue("answer");
                    data.status = getRDOValue("quizStatus");
                    data.mode = $('#quizmode').val();
                    data.quizuid = $('#quizuid').val();
                    
                    var response = $.parseJSON(ajax('quizlist.aspx/saveQuiz', data));
                    if ($.trim(response.d) == 'true') {
                        formQuiz.data("kendoWindow").center().close();
                        $("#quizGrid").data("kendoGrid").dataSource.read();
                        $("#question").data("kendoEditor").value("");
                        $('#choice1').val("");
                        $('#choice2').val("");
                        $('#choice3').val("");
                        $('#choice4').val("");
                        setRDOValue("answer", 1);
                        setRDOValue("quizStatus", 1);
                    }
                }
            });
        }//end eventhandle
        this.validation = function () {
            validator = $('#scriptForm').kendoValidator().data("kendoValidator"), status = $('#error');
            quizvalidator = $("#formQuiz").kendoValidator().data("kendoValidator");
        }//end validator
        this.clearform = function () {
            $("#kendoGrid").data("kendoGrid").clearSelection();
            $("#kendoGrid").data("kendoGrid").dataSource.read();
            $("#kendoGrid").data("kendoGrid").refresh();
            HTMLFormElement.prototype.reset.call($('#scriptForm')[0]);
            $("#description").data("kendoEditor").value("");
            ajax("quizlist.aspx/clearSessionQuiz", ({}));
            $("#quizGrid").data("kendoGrid").dataSource.read();
            var lastID = $.parseJSON($.parseJSON(ajax('quizlist.aspx/getLastID', ({}))).d).Table[0];
            $('#quizListID').val(lastID.lastID);
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
                                <h2>จัดการข้อมูลข้อสอบ</h2>
                            </div>
                            <div class="module-content">
                                <div class="custom">
                                    <form runat="server" id="scriptForm" action="quizlist.aspx" method="post" name="scriptForm">
                                        <input id="mode" name="mode" type="hidden" value="insert" />
                                        <fieldset>
                                            <legend>รายการข้อสอบ</legend>
                                            <div id="kendoGrid">
                                            </div>
                                        </fieldset>
                                        <fieldset>
                                            <legend>ข้อมูลข้อสอบ</legend>
                                            <div>
                                                <div>
                                                    <label>ลำดับ :</label>
                                                    <input id="quizListID" class="input" name="quizListID" readonly="" title="คลิกปุ่มเพิ่มข้อมูลเพื่อสร้างรหัสใหม่" type="text" />
                                                    <span class="k-invalid-msg" data-for="quizListID"></span>
                                                </div>
                                                <div>
                                                    <label>ชื่อข้อสอบ :</label>
                                                    <input id="title" class="input" name="title" required="required" title="พิมพ์ชื่อข้อสอบ" type="text" />*
							<span class="k-invalid-msg" data-for="title"></span>
                                                </div>
                                                <div>
                                                    <label>รายละเอียดข้อสอบ :</label>
                                                    <textarea id="description" name="description" cols="20" rows="2" title="พิมพ์รายละเอียด"></textarea>
                                                    <span class="k-invalid-msg" data-for="description"></span>
                                                </div>
                                                <div class="clear" style="height: 10px">
                                                </div>
                                                <div>
                                                    <label>วันที่เริ่มให้ทำข้อสอบ :</label>
                                                    <input id="dateTimeFrom" name="dateTimeFrom" required="required" title="เลือกวันเดือนปีที่ให้ทำข้อสอบ" />*
							<span class="k-invalid-msg" data-for="dateTimeFrom"></span>
                                                </div>
                                                <div>
                                                    <label>วันที่สิ้นสุดให้ทำข้อสอบ :</label>
                                                    <input id="dateTimeTo" name="dateTimeTo" required="required" title="เลือกวันเดือนปีที่สิ้นสุดให้ทำข้อสอบ" />*
							<span class="k-invalid-msg" data-for="dateTimeTo"></span>
                                                </div>
                                                <div>
                                                    <label>ชุดข้อสอบ :</label>
                                                    <input id="quizNumber" class="input" name="quizNumber" required="required" title="พิมพ์ชุดข้อสอบ" type="text" />*
							<span class="k-invalid-msg" data-for="quizNumber"></span>
                                                </div>
                                                <div>
                                                    <label>จำนวนข้อ :</label>
                                                    <input id="numberQuiz" class="input" name="numberQuiz" required="required" title="พิมพ์จำนวนข้อ" type="text" />*
							<span class="k-invalid-msg" data-for="numberQuiz"></span>
                                                </div>
                                                <div>
                                                    <label>รหัสหลักสูตร :</label>
                                                    <input id="courseID" class="input" name="courseID" title="พิมพ์รหัสหลักสูตร" type="text" />
                                                    <span class="k-invalid-msg" data-for="courseID"></span>
                                                </div>
                                                <div>
                                                    <label>สถานที่จัดอบรม :</label>
                                                    <input id="location" class="input" name="location" title="พิมพ์สถานที่จัดอบรม" type="text" />
                                                    <span class="k-invalid-msg" data-for="location"></span>
                                                </div>
                                                <div>
                                                    <label>สถานะ :</label>
                                                    <input id="status0" name="status" title="Inctive" type="radio" value="0" />ไม่ใช้งาน
							<input id="status1" checked="checked" name="status" title="Active" type="radio" value="1" />ใช้งาน
                                                </div>
                                            </div>
                                            <div class="clear" style="height: 10px">
                                            </div>
                                            <div id="quizGrid">
                                            </div>
                                            <div id="formQuiz" style="font-size: 14px;">
                                                <input id="quizmode" name="quizmode" type="hidden" value="insertQuiz" />
                                                <input id="quizuid" name="quizuid" type="hidden" value="" />
                                                <input id="quizID" name="quizID" type="hidden" />
                                                <div>
                                                    <label>คำถาม :</label>
                                                    <textarea id="question" name="question" cols="20" rows="2" title="พิมพ์คำถาม" required="required"></textarea>
                                                    <span class="k-invalid-msg" data-for="question"></span>
                                                </div>
                                                <div class="clear" style="height: 10px">
                                                </div>
                                                <div>
                                                    <label>ตัวเลือกที่ 1 :</label>
                                                    <textarea id="choice1" name="choice1" cols="20" rows="2" title="พิมพ์ตัวเลือกที่ 1" required="required"></textarea>*
                                                    <span class="k-invalid-msg" data-for="choice1"></span>
                                                </div>
                                                <div>
                                                    <label>ตัวเลือกที่ 2 :</label>
                                                    <textarea id="choice2" name="choice2" cols="20" rows="2" title="พิมพ์ตัวเลือกที่ 2" required="required"></textarea>*
                                                    <span class="k-invalid-msg" data-for="choice2"></span>
                                                </div>
                                                <div>
                                                    <label>ตัวเลือกที่ 3 :</label>
                                                    <textarea id="choice3" name="choice3" cols="20" rows="2" title="พิมพ์ตัวเลือกที่ 3" required="required"></textarea>*
                                                    <span class="k-invalid-msg" data-for="choice3"></span>
                                                </div>
                                                <div>
                                                    <label>ตัวเลือกที่ 4 :</label>
                                                    <textarea id="choice4" name="choice4" cols="20" rows="2" title="พิมพ์ตัวเลือกที่ 4" required="required"></textarea>*
                                                    <span class="k-invalid-msg" data-for="choice4"></span>
                                                </div>
                                                <div>
                                                    <label>ตัวเลือกที่ถูกต้อง :</label>
                                                    <input id="answer0" name="answer" type="radio" title="เลือกตัวเลือกที่ถูกต้อง" value="1" checked="checked" />1&nbsp;
                                                    <input id="answer1" name="answer" type="radio" title="เลือกตัวเลือกที่ถูกต้อง" value="2" />2&nbsp;
                                                    <input id="answer2" name="answer" type="radio" title="เลือกตัวเลือกที่ถูกต้อง" value="3" />3&nbsp;
                                                    <input id="answer3" name="answer" type="radio" title="เลือกตัวเลือกที่ถูกต้อง" value="4" />4&nbsp;
                                                </div>
                                                <div>
                                                    <label>สถานะ :</label>
                                                    <input id="quizStatus0" name="quizStatus" title="Inctive" type="radio" value="0" />ไม่ใช้งาน
							                        <input id="quizStatus1" checked="checked" name="quizStatus" title="Active" type="radio" value="1" />ใช้งาน
                                                </div>
                                                <input id="saveQuiz" class="k-button" name="saveQuiz" type="button" value="บันทึกข้อคำถาม" />
                                            </div>
                                            
                                            
                                        </fieldset>
                                        <div class="clear" style="height: 10px">
                                            </div>
                                        <input id="save" class="k-button" name="save" type="button" value="บันทึก" />
                                            <img id="loading" alt="" src="images/loading.gif" style="vertical-align: middle; display: none;" />
                                            <p id="error" class="warning">Message</p>
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
