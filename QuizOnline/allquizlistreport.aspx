<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="allquizlistreport.aspx.cs" Inherits="QuizOnline.allquizlistreport" %>

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
        $(function () {
            $("#list").mCustomScrollbar({ scrollButtons: { enable: true } });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
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
            <div >
              <h2>All Quiz Report</h2>
            </div>
              <hr/>
            <div class="module-content">
              <div class="custom" style="height: 300px;" id="list">
                  <asp:Repeater runat="server" ID="quizlist">
                                    <HeaderTemplate>
                                        <ul class="list-news">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <li><a target="_blank" href='quizListrpt.aspx?quizListID=<%# Eval("quizListID")%>' title="header=[<%# Eval("description")%>] body=[&nbsp;] fade=[on]"><%# Eval("title")%> [<%# DateTime.Parse(Eval("valueDate").ToString()).ToString("yyyy-MM-dd")%>]</a></li>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </ul>
                                    </FooterTemplate>
                                </asp:Repeater>
                </div>
            </div>
          </div>
        </div>


                        <div class="clear"></div>

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
    </form>
</body>
</html>

