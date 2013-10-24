<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="doquiz.aspx.cs" Inherits="QuizOnline.doquiz" %>
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
        var validator = $("#answerblock");
        var status = $('#error');
        this.initial = function () {
            $('#error').hide();
            $("#questionlist,#answerlist").mCustomScrollbar({ scrollButtons: { enable: true } });
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
                if (validator.validate()) {
                    status.hide();
                    $('#loading').show();
                    var options = {
                        success: function (response) {
                            $('#loading').hide();
                            var res = $.trim(response).split(',');
                            if (res[0] == 'true') {
                                if (res[1] == '1') {
                                    alert("ยินดีด้วยคุณสอบผ่าน คุณสามารถพิมพ์ใบประกาศสำหรับการสอบครั้งนี้ได้");
                                    $(location).attr('href', 'printcertificate.aspx?title='+$('#title').text());
                                } else {
                                    
                                    var data = new Object();
                                    data.userID = $('#userID').val();
                                    var dateobj= new Date(); 
                                    var month = dateobj.getMonth(); 
                                    var day = dateobj.getDate();
                                    var year = dateobj.getFullYear();
                                    var lastDay = new Date(year, month + 1, 0);
                                    var NextDay = new Date(year, month + 2, 15);
                                    lastDay = lastDay.getFullYear() + '-' + lastDay.getMonth() + '-' + lastDay.getDate();
                                    NextDay = NextDay.getFullYear() + '-' + NextDay.getMonth() + '-' + NextDay.getDate();
                                    
                                    data.valueDate = day >= 1 && day <= 15 ? lastDay : NextDay;
                                    data.courseID = $('#courseID').val();
                                    data.location = $('#location').val();
                                    
                                    var response = $.parseJSON(ajax('training.aspx/insert', data));
                                    if ($.trim(response.d) == 'true') {
                                        alert("คุณไม่ผ่านการทดสอบ\rคุณสามารถลงทะเบียนเข้ารับการอบรม หลักสูตร " + data.courseID + "\rในวันที่ " + data.valueDate + " สถานที่คือ " + data.location);
                                    } else {
                                        alert("ไม่สามารถลงทะเบียนเพื่อเข้ารับการอบรมได้ กรุณาติดต่อผู้ดูแลระบบ");
                                    }
                                }
                                _Redirect('main.aspx');
                            } else {
                                alert("ไม่สามารถดำเนินการได้!");
                            }
                        }
                    };
                    $("#scriptForm").ajaxSubmit(options);
                } else {
                    status.html("ยังเลือกคำตอบไม่ครบ.").show();
                }
            });
        }//end eventhandle
        this.validation = function () {
            validator = $('#scriptForm').kendoValidator({
                rules: {
                    radio: function (input) {
                        if (input.is("[type=radio]") && input.attr("required")) {
                            return $("#scriptForm").find("[name=" + input.attr("name") + "]").is(":checked");
                        }
                        return true;
                    }
                },
                messages: {
                    radio: "เลือกคำตอบ"
                }
            }).data("kendoValidator"), status = $('#error');
        }//end validator
        this.clearform = function () {
            $(':radio').prop('checked', false);
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
                            <input id="userID" type="hidden" runat="server"/>
                            
                            : <a href="logout.aspx" style="color: yellow;">Logout</a>
                        </p>
                    </div>
                </header>
                <!-- #header-->
                <div id="content">
                    <div class="block">
                        <div class="module-surround">
                            <div>
                                <h2>Description </h2>
                            </div>
                            <div class="module-content">
                                <div class="custom">
                                    <div><b style="color: black;">ชื่อข้อสอบ :</b><span id="title" runat="server"></span></div>
                                    <div><b style="color: black;">รายละเอียดข้อสอบ :</b><span id="description" runat="server"></span></div>
                                    <div><b style="color: black;">วันที่เริ่มให้ทำข้อสอบ :</b><span id="dateTimeFrom" runat="server"></span></div>
                                    <div><b style="color: black;">วันที่สิ้นสุดให้ทำข้อสอบ :</b><span id="dateTimeTo" runat="server"></span></div>
                                    <div><b style="color: black;">ชุดข้อสอบ :</b><span id="quizNumber" runat="server"></span></div>
                                    <div><b style="color: black;">จำนวนข้อ :</b><span id="numberQuiz" runat="server"></span></div>
                                    <input id="courseID" type="hidden" runat="server" />
                                    <input id="location" type="hidden" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="questionblock" class="block">
                        <div style="overflow: hidden">
                            <span class="blockhead-l">
                                <h2>Question</h2>
                            </span>
                        </div>
                        <hr />
                        <div id="questionlist" style="height: 300px;">

                            <asp:Repeater runat="server" ID="questions">
                                <HeaderTemplate>
                                    <table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td colspan="2"><%# Eval("no")%>) <%# HttpUtility.HtmlDecode(Eval("question").ToString())%></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;</td>
                                        <td>ก) <%# HttpUtility.HtmlDecode(Eval("choice1").ToString())%></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;</td>
                                        <td>ข) <%# HttpUtility.HtmlDecode(Eval("choice2").ToString())%></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;</td>
                                        <td>ค) <%# HttpUtility.HtmlDecode(Eval("choice3").ToString())%></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;</td>
                                        <td>ง) <%# HttpUtility.HtmlDecode(Eval("choice4").ToString())%></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <div id="answerblock" class="block">
                        <form runat="server" id="scriptForm" action="doquiz.aspx" method="post" name="scriptForm">
                            <h2>Answer</h2>
                            <hr />
                            <div id="answerlist" style="height: 300px;">
                                <input id="txtquizListID" name="txtquizListID" type="hidden" runat="server" />
                                <asp:Repeater runat="server" ID="answers">
                                    <HeaderTemplate>
                                        <table style="border-spacing: 10px;">
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>ก</td>
                                                <td>ข</td>
                                                <td>ค</td>
                                                <td>ง</td>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("no")%></td>
                                            <td>
                                                <input id="i1_<%# Eval("quizID")%>" name="a<%# Eval("quizID")%>" type="radio" value="1" required="required" />
                                                <span class="k-invalid-msg" data-for="i1_<%# Eval("quizID")%>"></span>
                                            </td>
                                            <td>
                                                <input id="i2_<%# Eval("quizID")%>" name="a<%# Eval("quizID")%>" type="radio" value="2" required="required" />
                                                <span class="k-invalid-msg" data-for="i2_<%# Eval("quizID")%>"></span>
                                            </td>
                                            <td>
                                                <input id="i3_<%# Eval("quizID")%>" name="a<%# Eval("quizID")%>" type="radio" value="3" required="required" />
                                                <span class="k-invalid-msg" data-for="i3_<%# Eval("quizID")%>"></span>
                                            </td>
                                            <td>
                                                <input id="i4_<%# Eval("quizID")%>" name="a<%# Eval("quizID")%>" type="radio" value="4" required="required" />
                                                <span class="k-invalid-msg" data-for="i4_<%# Eval("quizID")%>"></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <input id="save" class="k-button" name="save" type="button" value="ส่งคำตอบและตรวจสอบ" />
                                <img id="loading" alt="" src="images/loading.gif" style="vertical-align: middle; display: none;" />
                                <p id="error" class="warning">Message</p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <!-- #content-->
    </div>
    <!-- #wrapper -->
    <footer class="footer">
        <!--#include file="footer.html"-->
    </footer>
    <!-- #footer -->
</body>
</html>
