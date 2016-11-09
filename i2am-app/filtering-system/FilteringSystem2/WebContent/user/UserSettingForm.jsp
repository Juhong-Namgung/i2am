<%@page import="knu.cs.dke.vo.ConditionLog" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
history.pushState(null, null, location.href); 
window.onpopstate = function(event) { 
history.go(1); 
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����</title>
<script language="javascript">
	function dataTypeChanged(){
		set_condition(document.getElementById("category").value);
	}
	function set_condition(sf){
		if(sf == "filtering"){
			//var select = document.getElementById("dataset");
			//var option_value = select.options[select.selectedIndex].value;
			var option_value = "Twitter";
			var condit_obj = document.getElementById("attribute");
			var op_obj = document.getElementById("operator");

			if(option_value == "Twitter"){ 	//twitter
				alert(option_value+"1");
				var textArr = ["�Ӽ�","����� �̸�","����� ID","������","���","����","�ؽ��±�"];
				var valueArr = ["attr","userName","userId","createdAt","lang","text","hashTag"];	
				var opText = ["��ȣ","=","<",">"];
				var opValue = ["oper","equal","smaller","bigger"];

				condit_obj.options.length = 0;
				op_obj.options.length = 0;
				for(i=0; i<textArr.length;i++){				
					var objOption = document.createElement("option");

					objOption.text = textArr[i];	
					objOption.value = valueArr[i];
					
					condit_obj.options.add(objOption);
				}
				
				for(i=0; i<opText.length;i++){
					var objOption = document.createElement("option");
					objOption.id = opValue[i];
					objOption.text = opText[i];
					objOption.value = opValue[i];
					
					op_obj.options.add(objOption);
				}
				
			} else if(option_value == "Network"){
				condit_obj.options.length = 0;
				op_obj.options.length = 0;
			}else{
				
			}
			opChangeByAlgo();
		}
	}
	
	function opChangeByAlgo(){
		var selectAlgo = document.getElementById("algorithm");
		var valueAlgo = selectAlgo.options[selectAlgo.selectedIndex].value;

		
		if(valueAlgo == "bloom"){
			document.getElementById("attribute").style.display='';
			document.getElementById("operator").style.display='';
			document.getElementById("con_text").style.display='';
			document.getElementById("addition").style.display='';
			document.getElementById("equal").style.display='';
			document.getElementById("smaller").style.display='none';
			document.getElementById("bigger").style.display='none';
			document.getElementById("condition_table").style.display='';

			document.getElementById("languages").style.display='none';
			//document.getElementById("keywords").style.display='none';
		}else if(valueAlgo == "bayesian"){
			document.getElementById("attribute").style.display='none';
			document.getElementById("operator").style.display='none';
			document.getElementById("con_text").style.display='none';
			document.getElementById("addition").style.display='none';
			document.getElementById("condition_table").style.display='none';

			document.getElementById("languages").style.display='';
			//document.getElementById("keywords").style.display='';
		}else{
			document.getElementById("attribute").style.display='';
			document.getElementById("operator").style.display='';
			document.getElementById("con_text").style.display='';
			document.getElementById("addition").style.display='';
			document.getElementById("equal").style.display='';
			document.getElementById("smaller").style.display='';
			document.getElementById("bigger").style.display='';
			document.getElementById("condition_table").style.display='';

			document.getElementById("languages").style.display='none';
			//document.getElementById("keywords").style.display='none';
		}
	}
	
	function addCondition(){
		var selectAttr = document.getElementById("attribute");
		var textAttr = selectAttr.options[selectAttr.selectedIndex].text;
		var valueAttr = selectAttr.options[selectAttr.selectedIndex].value;
		
		var selectOper = document.getElementById("operator");
		var textOper = selectOper.options[selectOper.selectedIndex].text;
		var valueAttr = selectAttr.options[selectAttr.selectedIndex].value;
		
		var textBoxValue = document.getElementById("con_text").value;
		
		if(textAttr != "�Ӽ�" && textOper != "��ȣ" && textBoxValue != ""){
			//alert(textAttr+textOper+textBoxValue);
			var idx = 10;
			//�� ���� ���� ã��
			for(i=1 ; i<=3 ; i++){
				if(document.getElementById("con"+i).value == "���� �Է��ϼ���"){
					if(idx > i) idx = i;
				}
			}
			if(idx == 10){
				alert("������ �� á���ϴ�");
			}else{
				document.getElementById("con"+idx).value = textAttr+textOper+textBoxValue;
				document.getElementById("con_secret"+idx).value = valueAttr+textOper+textBoxValue;
			}
		}else{ alert("������ ����� �Է��ϼ���.");}
	}
	
	function changeInput(input_method,form){
		if(input_method =="input_file"){
			document.getElementById("file_upload").style.display='';
			document.getElementById("streaming").style.display='none';
		}else{
			var selectAlgo = document.getElementById("algorithm");
			var selectValue = selectAlgo.options[selectAlgo.selectedIndex].value;
			document.getElementById("file_upload").style.display='none';
			form.reset();
			document.getElementById("input_api").checked = true;
			document.getElementById("streaming").style.display='';
			/*
			var seLength = selectAlgo.options.lenght;
			for(var i=0; i<seLength;i++){
				if(selectAlgo.options[i] == selectValue){
					selectAlgo.options[i].selected = true;
					break;
				}
			}
			*/
			opChangeByAlgo();
		}
		
	}
	
	function add_condition(){
		//�������� ���� �߰�
		var selectAttr = document.getElementById("attribute");
		var textAttr = selectAttr.options[selectAttr.selectedIndex].text;
		var valueAttr = selectAttr.options[selectAttr.selectedIndex].value;
		
		var selectOper = document.getElementById("operator");
		var textOper = selectOper.options[selectOper.selectedIndex].text;
		//var valueAttr = selectOper.options[selectAttr.selectedIndex].value;
		
		var input_value = document.getElementById("con_text").value;
		
		//���� ���̺�
		var condition_table = document.getElementById("condition_table");
		var condition_client = textAttr+" " +textOper+" "+input_value;
		var condition_server = valueAttr+textOper+input_value+"";
		//alert(condition_server);
		var row_index = condition_table.rows.length;
		
		var condition = "<input type='text' name='conditions_user' value='"+condition_client+"' readonly>";
		var server_condition = "<input type='text' name='conditions' value='"+condition_server+"' style='display:none'> ";
		var deleteButton = "<input type='button' value='����' onClick='remove_condition(this)' style='cursor:hand'>";
		newTr = condition_table.insertRow(row_index);
		newTr.idName = "condition"+row_index;
		
		newTd = newTr.insertCell(0);
		newTd.align="left";
		newTd.innerHTML = condition_client;

		newTd = newTr.insertCell(1);
		newTd.align = "center";
		newTd.innerHTML = server_condition+deleteButton;
		
		/*
		newTd = newTr.insertCell(2);
		newTd.align = "center";
		newTd.innerHTML = server_condition;
		*/

	}
	
	function remove_condition(delete_row){
		//�������� ���� ����
		var condition_table = document.getElementById("condition_table");
		var del_row = delete_row.parentElement.parentElement.rowIndex;
		alert(del_row);
		
		condition_table.deleteRow(del_row);
		
	}

	
</script>
</head>
<body onload="document.user_setting.reset();">


<form name='user_setting' action='setting' method='post' enctype="multipart/form-data">

<!-- ����ڰ� ������ ��� �� �� ���� -->
<jsp:useBean id="conLog"
	scope = "request"
	class = "java.util.ArrayList"
	type = "java.util.ArrayList<knu.cs.dke.vo.ConditionLog>"/>
	
<p align='center'><br><br><a href="setting"><img src="user/image/title.png" border='0' width='600'></a></p>
<!-- 
������ ����: <select id ='dataset' name='dataset' onchange="dataTypeChanged();"><br>
			<option value='Network'>��Ʈ��ũ</option><br>
			<option value='Twitter'>Ʈ����</option><br>
			<option value='gaussian'>����þ�</option><br>
		</select><br>  
-->
		
<!--  <input type='radio' name='category' value='sampling' checked='checked'>���ø� -->
<!-- <input type='radio' id='category' name='category' value='filtering' onclick="set_condition(this.value);">���͸�<br> -->

<p align='center'><input type='radio' id='input_file' name='input_method' value='input_file' onclick='changeInput(this.value,this.form);'>��ũ ��Ʈ��
<input type='radio' id='input_api' name='input_method' value='input_api' onclick='changeInput(this.value,this.form);'>�ǽð� ��Ʈ��</p>
<!-- file upload / twitterAPI -->
<p align='center'>
<input type='file' id='file_upload' name='stream_file' style="display:none">
<input type='text' id='streaming' name='realtime_source' style="display:none">
</p>

<!-- �˰��� ���� -->
<p align='center'><select id='algorithm' name='algorithm' onchange="opChangeByAlgo();"><br>
			<option id='ba' value='bayesian'>�������� ���͸�</option><br>
			<option id='bl' value='bloom'>��� ���͸�</option><br>
			<option id='qu' value='query'>���� ���͸�</option><br>
		</select></p>

<!-- ���͸� ���������� �ߵ��� �� (�������� ����) -->		
<!-- conditions �ڵ��߰� �������� -->
<p align='center'>
<!-- 
<select id='languages' name='languages'>
	<option value='languages'>���</option>
	<option value='ko'>ko</option>
	<option value='en'>en</option>
</select>
 -->
 <!-- �������� ���� -->
 <input type='text' id='languages' name='languages'>
</p>

<!-- �ٸ� ���� -->
<p align='center'>
<select id='attribute' name='attribute' style="display:none">
	<option value='attr'>�Ӽ�</option>	<option value='userName'>����� �̸�</option>
	<option value='userId'>����� ID</option>	<option value='createdAt'>������</option>
	<option value='lang'>���</option>	<option value='text'>����</option>
	<option value='numeric'>����</option>
</select>	<!--�Ӽ�-->
<select id='operator' name='operator' style="display:none">
	<option id='oper' value='oper'>��ȣ</option>	<option id='equal' value='equal'>=</option>
	<option id='smaller' value='smaller'>&lt;</option>	<option id='bigger' value='bigger'>&gt;</option>
	<option id='not_equal' value='not_equal'>!=</option>
</select>	<!--��ȣ-->
<input type='text' id='con_text' name='con_text' style="display:none">	<!--����-->
<img align='center' src='user/image/add.png' id='addition' name='add' onclick="add_condition();" width='23' style="display:none"> <!-- ���� �� addCondition() -->
<!-- <button type='button' id='addition' name='add' onclick="addCondition();" style="display:none">���� �߰�</button> -->
<br><br>

</p>

<p align='center'>
<table align='center' id='condition_table' width='200'>
</table>
</p>

<p align='center'><input TYPE='IMAGE' src="user/image/check.png" name='Submit' value='Submit' width='50' align='absmiddle'></p>


<!-- <input type='submit' value='����'> -->
</form>

</body>
</html>