<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="traininglistbyuser.aspx.cs" Inherits="QuizOnline.traininglistbyuser" %>

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
        script.eventhandle();
    });
    var script = new function () {
        var validator = $("#scriptForm");
        var status = $('#error');
        this.initial = function () {
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
                        template: '<a class="k-button" href="javascript:;" id="report"><img src="images/mono-icons/doc_plus.png" width="12px">รายงาน</a>'
                    }

                ]
            });

        }//end initial
        this.eventhandle = function () {
            $("#report").click(function () {
                var kendoGrid = $("#kendoGrid").data("kendoGrid");
                var selectedItem = kendoGrid.dataItem(kendoGrid.select());
                if (selectedItem == null) { alert('กรุณาเลือกรายการที่ต้องการรายงาน.'); return; }
                window.open('traininglistbyuserrpt.aspx?userID=' + selectedItem.userID);
                   // $(location).attr('href', 'traininglistbyuserrpt.aspx?userID='+selectedItem.userID).attr('target','_blank');
            });
            
        }//end eventhandle
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


