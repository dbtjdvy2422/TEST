<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<h1>Upload with Ajax</h1>

<div class='uploadDiv'>
    <input type="file" name="uploadFile" multiple>

</div>
<button id='uploadBtn'>upload</button>



</body>

<script
        src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>

<script>
    $(document).ready(function(){

        var regex= new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize =5242880; // 5MB

        function checkExtension(fileName, filesize){
            if(filesize>= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }
            return true;
        }

        $("#uploadBtn").on("click", function(e){
            var formData = new FormData();
            var inputFile =$("input[name='uploadFile']");
            var files =inputFile[0].files;
            console.log(files);

            for(var i =0; i< files.length; i++) {
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url: '/uploadAjaxAction',
                processData :false,
                contentType: false,
                data: formData,
                type:'post',
                dataType: 'json',
                success: function(result){
                   console.log(result);
                }
            });

        });

    });
</script>

</html>
