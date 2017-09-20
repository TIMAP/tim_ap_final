/**
 * 
 */

function check() {
    var file = $("#excelFile").val();
    if (file == "" || file == null) {
        alert("파일을 선택해주세요.");
        return false;
    } 

    if (confirm("업로드 하시겠습니까?")) {
        var options = {
            success : function(data) {
                alert("모든 데이터가 업로드 되었습니다.");
            },
            type : "POST",
            error:function(){
            	alert("이미 등록된 사용자가 존재합니다");
            }
        };
        $("#excelInsertForm").ajaxSubmit(options);

    }
    
    
}

function checkCsv() {
    var file = $("#csvFile").val();
    if (file == "" || file == null) {
        alert("파일을 선택해주세요.");
        return false;
    } 
    
    if (confirm("업로드 하시겠습니까?")) {
        var options = {
            success : function(data) {
                alert("양식이 업로드 되었습니다.");
            },
            type : "POST",
            error:function(){
            	alert("이미 등록된 사용자가 존재합니다");
            }
        };
        $("#csvInsertForm").ajaxSubmit(options);

    }
    
}

function checkUpload() {
    var file = $("#f").val();
    if (file == "" || file == null) {
        alert("파일을 선택해주세요.");
        return false;
    } 
    
    if (confirm("업로드 하시겠습니까?")) {
        var options = {
            success : function(data) {
                alert("양식이 업로드 되었습니다.");
            },
            type : "POST"
        };
        $("#excelUploadForm").ajaxSubmit(options);

    }
    
}




    
//    if (confirm("업로드 하시겠습니까?")) {
//        var options = {
//            success : function(data) {
//                alert("모든 데이터가 업로드 되었습니다.");
//            },
//            type : "POST",
//            error:function(x){
//            	alert("이미 등록된 사용자가 존재합니다");
//            }
//        };
//        $("#csvInsert").ajaxSubmit(options);
//
//    }