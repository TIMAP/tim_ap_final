/**
 * 
 */

function check() {
    var file = $("#excelFile").val();
    if (file == "" || file == null) {
        alert("파일을 선택해주세요.");
        return false;
    } 
    
    var excelInsertForm = document.getElementById("excelInsertForm");
    excelInsertForm.action = "/member/excelInsertMember";
    excelInsertForm.submit();
    
}


function checkCsv() {
    var file = $("#csvFile").val();
    if (file == "" || file == null) {
        alert("파일을 선택해주세요.");
        return false;
    } 
    var csvInsertForm = document.getElementById("csvInsertForm");
    csvInsertForm.action = "/member/csvInsertMember";
    csvInsertForm.submit();
    
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




function memberInfo(id){
	alert(id);
	location.href="/admin/memberInfo?id="+id;
}



function memberMg() {
	$('.managementForm').submit();
}