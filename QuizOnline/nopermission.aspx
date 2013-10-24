<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nopermission.aspx.cs" Inherits="QuizOnline.nopermission" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>QuizOnline System</title>
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <link rel="stylesheet" href="css/menu.css" type="text/css" />
    <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="js/utility.js"></script>
    <script type="text/javascript">
        $(function () {
            evenhandle();
        });
        function evenhandle() {
            $('#txtusername,#txtpassword').focus(function (e) {
                $('.status').hide("slow").html("");
            });
            $('#btnlogin').click(function (e) {
                login.username = $('#txtusername').val();
                login.password = $('#txtpassword').val();
                var response = login.getlogin();
                if ($.trim(response.d) == 'true') {
                    $(window.location).attr('href', 'main.aspx');
                } else {
                    $(".status").html("Username or Password is invalid.").css('color', 'yellow').show();
                }
            });
        }
        var login = new function () {
            this.username = "";
            this.password = "";
            this.getlogin = function () {
                var datastring = new Object();
                datastring.username = this.username;
                datastring.password = this.password;

                var data_response = $.parseJSON($.ajax({
                    type: "POST",
                    url: 'default.aspx/checkUser',
                    data: JSON.stringify(datastring),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false
                }).responseText);
                return data_response;
            };
        }
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
                </header>
                <!-- #header-->
                <div id="content">
                    <div class="block" id="loginbox" style="width:800px;">
                        <div class="module-surround">
                            <div>
                                <h1>คุณไม่มีสิทธิ์ในการเข้าใช้งานหน้านี้ กรุณาติดต่อ ผู้ดูแลระบบ</h1>
                            </div>
                            <div class="module-content">
                                <div class="custom" style="margin:0 auto;">
                                    <table border="0" cellpadding="1" cellspacing="3">
                                        <tr>
                                            <td colspan="3" class="status"></td>
                                        </tr>
                                        <tr>
                                            <td>Username</td>
                                            <td>:</td>
                                            <td>
                                                <input id="txtusername" name="txtusername" type="text" class="inputbox" autocomplete="off" /></td>
                                        </tr>
                                        <tr>
                                            <td>Password</td>
                                            <td>:</td>
                                            <td>
                                                <input id="txtpassword" name="txtpassword" type="password" class="inputbox" autocomplete="off" /></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td><a href="javascript:;" id="btnlogin" class="readon"><span>Login</span></a></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #content-->

                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
            </div>
            <!-- #wrapper -->
            <footer class="footer">
                <!--#include file="footer.html"-->
            </footer>
            <!-- #footer -->
        </div>
    </div>
</body>
</html>
