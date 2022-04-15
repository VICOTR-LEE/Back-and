package com.lec.ex03readerwriter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

public class Ex02_Writer {

	public static void main(String[] args) {
		Writer writer = null;
		try {
			writer = new FileWriter("test_File/outTest.txt", true); // true 덮어쓰기 
			String msg = "\n\n 추가한 텍스트 파일 입니다. 안녕하세요";
			writer.write(msg);
			System.out.println("파일 출력 성공");
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(writer!=null)writer.close();
			} catch (Exception e2) {}
		}

	}

}
