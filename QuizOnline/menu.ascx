<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu.ascx.cs" Inherits="QuizOnline.menu" %>
<nav id="menu-wrap">
    <ul id="menu">
        <li><a href="main.aspx">Home</a></li>
        <li id="users" runat="server"><a href="users.aspx">Users</a>
            <ul>
                <li id="usertype" runat="server"><a href="usertype.aspx">User Type</a></li>
                <li id="userrole" runat="server"><a href="userrole.aspx">User Role</a></li>
            </ul>
        </li>
        <li id="quizlist" runat="server"><a href="quizlist.aspx">Manage Quiz</a> </li>
        <li id="allquizlist" runat="server"><a href="allquizlist.aspx">Quiz List</a></li>
        <li id="course" runat="server"><a href="course.aspx">Course</a></li>
        <li id="traning" runat="server"><a href="training.aspx">Training</a></li>
        <li id="certificate" runat="server"><a href="certificate.aspx">Certificate</a></li>
        <li id="announcement" runat="server"><a href="announcement.aspx">Announcement</a> </li>
        <li id="report" runat="server"><a href="#">Report</a>
            <ul>
                <li><a href="userlist.aspx" target="_blank">User List</a></li>
                <li><a href="allquizlistreport.aspx">Quiz List</a></li>
                <li><a href="traininglist.aspx" target="_blank">Training List</a> </li>
                <li><a href="traininglistbyuser.aspx">Training List by user</a> </li>
                <li><a href="#">Training List by course</a> </li>
                <li><a href="#">Summary</a> </li>
            </ul>
        </li>
        

    </ul>
</nav>

