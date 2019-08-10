//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lisa Fisher on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bookLabel: UILabel!
    
    @IBOutlet weak var readButton: UIButton!
    

    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        readButton.setImage(UIImage(named: "checked"), for: [.selected])
    }
}

