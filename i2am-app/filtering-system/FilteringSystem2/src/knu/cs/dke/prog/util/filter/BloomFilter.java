package knu.cs.dke.prog.util.filter;

import java.util.List;

public class BloomFilter {
	public static boolean[] BloomFilter;
	
	public static boolean isExist(List<Integer> idx){
		boolean exist = true;
		for(int i=0; i<idx.size();i++){
			if(!BloomFilter[idx.get(i)]){ //�ϳ��� ��ġ���� ������ false
				exist = false;
			}
		}
		return exist;
	}
	
}
