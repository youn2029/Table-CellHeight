//
//  ListViewController.swift
//  Table-CellHeight
//
//  Created by 윤성호 on 12/02/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    // 데이블 뷰에 연결될 데이터를 저장하는 배열
    var list = [String]()
    
    // 글 추가 버튼
    @IBAction func add(_ sender: Any) {
        
        // 알림창 객체의 인스턴스를 생성
        let alert = UIAlertController(title: "목록입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert)
        
        // 알림창에 입력폼을 추가
        alert.addTextField(){
            (tf) in
            tf.placeholder = "내용을 입력해주세요"
        }
        
        // OK 버튼 객체를 생성
        let ok = UIAlertAction(title: "OK", style: .default) {
            (_) in
            
            // 알림창의 0번째 입력필드에 값이 있다면
            if let title = alert.textFields?[0].text {
                
                // 배열에 입력된 값을 추가하고 테이블 갱신
                self.list.append(title)
                self.tableView.reloadData() // 테이블 뷰를 갱신
            }
        }
        
        // 취소 버튼 객체를 생성
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        // 버튼을 알림창에 추가
        alert.addAction(ok)
        alert.addAction(cancel)
        
        // 알림창 띄우기
        self.present(alert, animated: false)
    }
    
    // 테이블 뷰의 가로 행 수를 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // 테이블 뷰의 가로 행 내용을 결정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // cell 아이디를 가진 셀을 읽어온다. 없으면 UITableViewCell 인스턴스를 생성한다 (Nil-Coalescing Operator)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()

        
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당
        cell.textLabel?.text = self.list[indexPath.row]
        
        return cell
    }    
    
    // 입력된 글의 길이를 체크하여 셀의 높이를 조절해 줄 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.list[indexPath.row]
        
        // 높이를 조절해준다. 기본 높이 60 + 글의 길이가 30자를 넘어갈 때마다 20만큼씩 높이를 늘려준다
        let height = CGFloat(60 + (row.count / 10) * 20)
        NSLog("\(height)")
        
        return height
    }
}
