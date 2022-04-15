package com.lec.ex2_swing;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

public class Ex01_Thrusday extends JFrame implements ActionListener{
	private JPanel panel; //받아온 컨테이너를 저장
//	private Container contenPane; // 받아온 컨테이너럴 저장
	private JLabel jlbl;
	private JButton jbtn;
	public Ex01_Thrusday(String title) { // 컨테이너 받아와서 컴포넌트 add
		super(title);
		setDefaultCloseOperation(EXIT_ON_CLOSE); // x 버튼 클릭시 종료
		// 스윙은 컨테이너 얻어오기(맨처음)
		panel =(JPanel) getContentPane();
		panel.setLayout(new FlowLayout());
		jbtn = new JButton("EXIT");
		jlbl = new JLabel("집가고싶다..", (int) CENTER_ALIGNMENT);
		
		panel.add(jlbl);
		jlbl.setPreferredSize(new Dimension(150, 200));
		panel.add(jbtn);
		jbtn.setPreferredSize(new Dimension(200, 200));
		setVisible(true);
		setSize(new Dimension(400, 250));
		setLocation(200, 50);
		// 이벤트 리스너 추가 
		jbtn.addActionListener(this);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource() == jbtn) {
			setVisible(false); // 안보이게
			dispose(); // 자원해제
			System.exit(0); // 강제종료
		}
		
	}
	public static void main(String[] args) {
		new Ex01_Thrusday("title");
	}
	
}
