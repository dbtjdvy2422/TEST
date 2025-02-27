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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../includes/header.jsp" %>

<style>
    .uploadResult {
        width: 100%;
        background-color: gray;
    }

    .uploadresult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }

    .uploadResult ul li {
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }

    .uploadResult ul li img {
        width: 100%;
    }

    .uploadResult ul li span {
        color: white;
    }

    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255, 255, 255, 0.5);
    }

    .bicPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img {
        width: 600px;
    }

</style>
<body>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Register</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read Page</div>
            <div class="panel-body">
                <div class="form-group">
                    <label>Bno</label>
                    <input class="form-control" name="bno" value="${board.bno }" readonly>
                </div>
                <div class="form-group">
                    <label>Title</label>
                    <input class="form-control" name="title" value="${board.title }" readonly>
                </div>
                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content" readonly>${board.content }</textarea>
                </div>
                <div class="form-group">
                    <label>Writer</label>
                    <input class="form-control" name="writer" value="${board.writer }" readonly />
                </div>

                <sec:authentication property="principal" var="pinfo"/>
                <sec:authorize access="isAuthenticated()">
                    <c:if test="${pinfo.username eq board.writer }">
                        <button data-oper="modify" class="btn btn-default">Modify</button>
                    </c:if>
                </sec:authorize>



                <button data-oper="list" class="btn btn-info">List</button>

                <form id="operForm" action="/board/modify" method="get">
                    <input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno }'/>">
                    <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>">
                    <input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
                    <input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
                    <input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
                </form>
            </div>

            <div class="bigPictureWrapper">
                <div class="bigPicture">

                </div>
            </div>

            <div class="panel-heading">Files</div>
            <div class="panel-body">
                <div class="uploadResult">
                    <ul>

                    </ul>
                </div>
            </div>

            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply
                <sec:authorize access="isAuthenticated()">
                    <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
                </sec:authorize>
            </div>
            <div class="panel-body">
                <ul class="chat">
                    <!-- <li class="left clearfix" data-rno="12">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2018-01-01 13:13</small>
                            </div>
                            <p>Good job!</p>
                        </div>
                    </li> -->
                </ul>
            </div>

            <div class="panel-footer">

            </div>

        </div>
    </div>
</div>


<%@ include file="../includes/footer.jsp" %>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="New Reply!!!!">
                </div>

                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer" value="replyer">
                </div>

                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name="replyDate" value="">
                </div>

            </div>
            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>

                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>

                <button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>

                <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</body>
<script type="text/javascript" src="/resources/js/reply.js"></script>


<script type="text/javascript">
    $(document).ready(function() {


        (function() {
            var bno = '<c:out value="${board.bno}"/>';

            $.getJSON("/board/getAttachList", {bno : bno}, function(arr) {
                console.log("-------start");
                console.log(arr);
                console.log("-------end");

                var str = "";

                $(arr).each(function(i, attach) {
                    // image type
                    if (attach.fileType) {
                        var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

                        str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
                        str += "<div>";
                        str += "	<img src='/display?fileName=" + fileCallPath + "'>";
                        str += "</div>";
                        str += "</li>";

                    } else {
                        str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
                        str += "	<div>";
                        str += "		<span> " + attach.fileName + "</span><br/>";
                        str += "		<img src='/resources/img/test-image.jpg'></a>";
                        str += "	</div>";
                        str += "</li>";
                    }

                });

                $(".uploadResult ul").html(str);

            });

        })();

        $(".uploadResult").on("click", "li", function(e) {
            console.log("view image");

            var liObj = $(this);

            var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

            if (liObj.data("type")) {
                showImage(path.replace(new RegExp(/\\/g), "/"));
            } else {
                // download
                self.location = "/download?fileName=" + path;
            }

        });

        function showImage(fileCallPath) {
            alert("fileCallPath: " + fileCallPath);

            $(".bigPictureWrapper").css("display", "flex").show();

            $(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>")
                .animate({width: '100%', height: '100%'}, 1000);

        }

        $(".bigPictureWrapper").on("click", function(e) {
            $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);

            setTimeout(function() {
                $(".bigPictureWrapper").hide();
            }, 1000);

        });

        console.log("========================= start");
        console.log("JS TEST");
        var bnoValue = '<c:out value="${board.bno}" />';



        replyService.get(10, function(data) {
            console.log(data);
        });

        console.log("========================= end");

        var replyUL = $(".chat");

        showList(1);

        function showList(page) {
            console.log("show list " + page);

            replyService.getList(
                {
                    bno : bnoValue,
                    page : page || 1
                },
                // function(list) {
                function(replyCnt, list) {

                    console.log("replyCnt: " + replyCnt);
                    console.log("list: " + list);
                    console.log(list);

                    if (page == -1) {
                        pageNum = Math.ceil(replyCnt / 10.0);
                        showList(pageNum);
                        return;
                    }

                    var str = "";
                    if (list == null || list.length == 0) {
                        // replyUL.html("");
                        return;
                    }

                    for (var i = 0, len = list.length || 0; i < len; i++) {
                        str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
                        str += "	<div>";
                        str += "		<div class='header'>";
                        str += "			<strong class='primary-font'>" + list[i].replyer + "</strong>";
                        str += "			<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small>";
                        str += "		</div>";
                        str += "		<p>" + list[i].reply + "</p>";
                        str += "	</div>";
                        str += "</li>";
                    }

                    replyUL.html(str);

                    showReplyPage(replyCnt);
                }
            );
        }

        var operForm = $('#operForm');

        $("button[data-oper='modify']").on("click", function() {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function() {
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });

        var modal = $(".modal");
        var modalInputReply = modal.find("input[name='reply']");
        var modalInputReplyer = modal.find("input[name='replyer']");
        var modalInputReplyDate = modal.find("input[name='replyDate']");

        var modalModBtn = $("#modalModBtn");
        var modalRemoveBtn = $("#modalRemoveBtn");
        var modalRegisterBtn = $("#modalRegisterBtn");

        var replyer = null;

        <sec:authorize access="isAuthenticated()">
        replyer = '<sec:authentication property="principal.username"/>';
        </sec:authorize>
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";

        alert("test1: " + csrfHeaderName);
        alert("test2: " + csrfTokenValue);

        // Ajax spring security header.....
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });


        $("#addReplyBtn").on("click", function(e) {
            modal.find("input").val("");
            modal.find("input[name='replyer']").val(replyer);
            modalInputReplyDate.closest("div").hide();
            modal.find("button[id != 'modalCloseBtn']").hide();

            modalRegisterBtn.show();
            $(".modal").modal("show");
        });

        modalRegisterBtn.on("click", function(e) {
            var reply = {
                reply : modalInputReply.val(),
                replyer : modalInputReplyer.val(),
                bno : bnoValue
            };
            replyService.add(reply, function(result) {
                alert(result);

                modal.find("input").val("");
                modal.modal("hide");

                // showList(1);
                showList(-1); // 전체 댓글 숫자 파악
            });
        });

        $(".chat").on("click", "li", function(e) {
            var rno = $(this).data('rno');

            replyService.get(rno, function(reply) {
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer);
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
                modal.data("rno", reply.rno);

                modal.find("button[id != 'modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            });
        });


        modalRemoveBtn.on("click", function(e) {
            var rno = modal.data("rno");

            console.log("RNO: " + rno);
            console.log("REPLYER: " + replyer);

            if (!replyer) {
                alert("로그인 후 삭제가 가능합니다.");
                modal.modal("hide");
                return;
            }

            var originalReplyer = modalInputReplyer.val(); // 댓글의 원래 작성자

            console.log("Original Replyer: " + originalReplyer); // 댓글의 원래 작성자

            if (replyer != originalReplyer) {
                alert("자신이 작성한 댓글만 삭제가 가능합니다.");
                modal.modal("hide");
                return;
            }


            replyService.remove(rno, originalReplyer, function(result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });

        var pageNum = 1;
        var replyPageFooter = $(".panel-footer");

        function showReplyPage(replyCnt) {
            var endNum = Math.ceil(pageNum / 10.0) * 10;
            var startNum = endNum - 9;

            var prev = startNum != 1;
            var next = false;

            if (endNum * 10 >= replyCnt) {
                endNum = Math.ceil(replyCnt / 10.0);
            }

            if (endNum * 10 < replyCnt) {
                next = true;
            }

            var str = "<ul class='pagination pull-right'>";

            if (prev) {
                str += "<li class='page-item'><a class='page-link' href='" + (startNum -1) + "'>Previous</a></li>";
            }

            for (var i = startNum; i <= endNum; i++) {
                var active = pageNum == i ? "active" : "";

                str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'></a></li>";
            }

            if (next) {
                str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log(str);

            replyPageFooter.html(str);

        }

        replyPageFooter.on("click", "li a", function(e) {
            e.preventDefault();
            console.log("page click");

            var targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            pageNum = targetPageNum;

            showList(pageNum);
        });

        modalModBtn.on("click", function(e) {
            var originalReplyer = modalInputReplyer.val();

            var reply = {
                rno : modal.data("rno"),
                reply : modalInputReply.val(),
                replyer : originalReplyer
            };

            if (!replyer) {
                alert("로그인 후 수정이 가능합니다.");
                modal.modal("hide");
                return;
            }

            console.log("Original Replyer: " + originalReplyer);

            if (replyer != originalReplyer) {
                alert("자신이 작성한 댓글만 수정이 가능합니다.");
                modal.modal("hide");
                return;
            }

            replyService.update(reply, function(result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });

    });
</script>

