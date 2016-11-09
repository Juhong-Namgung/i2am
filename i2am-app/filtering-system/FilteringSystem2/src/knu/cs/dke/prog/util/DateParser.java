package knu.cs.dke.prog.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateParser {
	String[] months = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	
	public long parse(String origin_date){
		long date;
		String[] date_split = origin_date.split(" ");
		//0:����, 1:��, 2:��, 3:�ú���, 4:���, 5:�⵵
		String[] hhmmss = date_split[3].split(":");
		String tmp = "";
		
		for(int i=0; i<months.length; i++){
			if(months[i].equals(date_split[1])){
				if(i<9){
					date_split[1] = "0"+(i+1);
					break;
				}else{
					date_split[1] = (i+1)+"";
					break;
				}
			}
		}
		
		//yyyyMMddhhmmss
		tmp = date_split[5]+date_split[1]+date_split[2]+hhmmss[0]+hhmmss[1]+hhmmss[2];
		date = Long.parseLong(tmp);
		
		return date;
	}
	
	public String longToDate(String original) throws Exception{
		String str_date=""+original;
		String result="";
		//yyyyMMddhhmmss -> ���� M d hh:mm:ss KST yyyy
		String year = str_date.substring(0,4);
		String month = str_date.substring(4,6);
		String date = str_date.substring(6,8);
		String yyyyMMdd = year+"-"+month+"-"+date;
		String dateType = "yyyy-MM-dd";
		
		//����ã��
		SimpleDateFormat dateFormat = new SimpleDateFormat(dateType);
		Date nDate = dateFormat.parse(yyyyMMdd);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(nDate);
		
		int dayNum = cal.get(Calendar.DAY_OF_WEEK);
		
		switch(dayNum){
			case 1:
				result = "Sun ";
				break;
			case 2:
				result = "Mon ";
				break;
			case 3:
				result = "Tue ";
				break;
			case 4:
				result = "Wed ";
				break;
			case 5:
				result = "Thu ";
				break;
			case 6:
				result = "Fri ";
				break;
			case 7:
				result = "Sat ";
				break;
		}
		//��(Month)
		result += months[Integer.parseInt(month)-1]+" ";
		//��(date)
		result += Integer.parseInt(date)+" ";
		//�ú���
		result += str_date.substring(8,10)+":"+str_date.substring(10,12)+":"+str_date.substring(12)+" ";
		//�⵵(year)
		result += "KST "+year;
		
		return result;
	}

}
