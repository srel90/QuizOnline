﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="traininglistbycourserpt.aspx.cs" Inherits="QuizOnline.traininglistbycourserpt" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">  
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="600px" Width="100%" ShowPrintButton="True">
        </rsweb:ReportViewer>

    </form>
</body>
</html>
