<%--
  Created by IntelliJ IDEA.
  User: yuseongpyo
  Date: 2022/02/17
  Time: 2:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../includes/header.jsp"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Board Register</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Board Register
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">

                    <div class="form-group">
                        <label>Bno</label>
                        <input class="form-control" name='bno'
                               value='<c:out value="${board.bno}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" name='title'
                               value='<c:out value="${board.title}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name='content'
                                  readonly="readonly">
						<c:out value="${board.content }"/>
					</textarea>
                    </div>
                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name='writer'
                               value='<c:out value="${board.writer}"/>' readonly="readonly">
                    </div>
                    <button data-oper='modify' class="btn btn-default"
                            onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify
                    </button>
                    <button data-oper='list' class="btn btn-info"
                            onclick="location.href='/board/list'">List
                    </button>
                    <form id="openForm" action="/board/modify" method="get">
                        <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>' >
                    </form>

                    </form>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-6 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->

</div>
<script type="text/javascript">
    $(document).ready(function() {
        var openForm = $("#openForm");
        $("button[data-oper='modify']").on("click", function(e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function(e) {
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });
    });
</script>
<%@include file="../includes/footer.jsp"%>

</body>

</html>

