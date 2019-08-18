//
//  TodoItemViewCell.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

protocol TodoItemViewCellDelegate: class {
    func didTapCheckBox(at item: ViewModel_TodoItem)
    func didTapDeleteButton(at item: ViewModel_TodoItem)
}

class TodoItemViewCell: BaseTableViewCell {
    
    override open class var CELL_IDENTIFIER: String { return "TodoItemViewCellID" }
    private var _viewModel: ViewModel_TodoItem?
    
    weak var delegate: TodoItemViewCellDelegate?
    
    private lazy var _checkBox: TodoCheckBox = {
        let checkbox = TodoCheckBox()
        checkbox.borderColor = UIColor.clear
        checkbox.checkedImage = UIImage(named: "checkbox_checked")
        checkbox.uncheckedImage = UIImage(named: "checkbox_uncheck")
        return checkbox
    }()
    
    private lazy var _todoName: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.numberOfLines = 0
        view.lineBreakMode = NSLineBreakMode.byWordWrapping
        return view
    }()
    
    private lazy var _deleteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "close_dark"), for: .normal)
        return view
    }()
    
    override func setupViews() {
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self._checkBox)
        self.contentView.addSubview(self._todoName)
        self.contentView.addSubview(self._deleteButton)
        
        self._checkBox.addTarget(self, action: #selector(didTapCheckbox), for: UIControl.Event.touchUpInside)
        self._deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: UIControl.Event.touchUpInside)
    }
    
    override func setupLayout() {
        self._checkBox.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        
        self._todoName.snp.remakeConstraints { (make) in
            make.top.equalTo(self._checkBox).offset(7)
            make.leading.equalTo(self._checkBox.snp.trailing).offset(20)
            make.trailing.equalTo(self._deleteButton.snp.leading).offset(-20)
        }
        
        self._deleteButton.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
        }
    }
    
    @objc func didTapCheckbox() {
        if let viewModel = self._viewModel {
            self.delegate?.didTapCheckBox(at: viewModel)
        }
    }
    
    @objc func didTapDeleteButton() {
        if let viewModel = self._viewModel {
            self.delegate?.didTapDeleteButton(at: viewModel)
        }
    }
    
    func configure(with viewModel: ViewModel_TodoItem) {
        self._viewModel = viewModel
        self._todoName.text = viewModel.name
        self._checkBox.isChecked = viewModel.isDone
    }
    
    override func prepareForReuse() {
        self._checkBox.isChecked = false
        self._todoName.text = ""
    }
}
