//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

class TodoListViewController: BaseViewController, TodoListViewProtocol {

    var presenter: TodoListPresenterInputProtocol?
    private var _filterType: FilterType = .All
    private var _todoTextService: TodoTextServiceProtocol
    
    init(todoTextService: TodoTextServiceProtocol) {
        self._todoTextService = todoTextService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var _textField: UITextField = {
        let view = UITextField()
        view.returnKeyType = UIReturnKeyType.done
        return view
    }()
    
    private lazy var _tableView: UITableView = {
        let view = UITableView()
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        view.separatorColor = UIColor.lightGray
        view.estimatedRowHeight = 60.0
        view.rowHeight = UITableView.automaticDimension
        view.register(TodoItemViewCell.self, forCellReuseIdentifier: TodoItemViewCell.CELL_IDENTIFIER)
        return view
    }()
    
    private lazy var _filterLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 20)
        view.numberOfLines = 0
        view.lineBreakMode = NSLineBreakMode.byWordWrapping
        view.text = self._todoTextService.text(key: .todo_list_filter_button)
        return view
    }()
    
    private lazy var _toggleAllButton: TodoButton = {
        let view = TodoButton()
        view.activeBackgroundColor = UIColor.blue
        view.setTitle(self._todoTextService.text(key: .todo_list_toggle_all_button), for: .normal)
        return view
    }()
    
    private lazy var _clearButton: TodoButton = {
        let view = TodoButton()
        view.activeBackgroundColor = UIColor.red
        view.setTitle(self._todoTextService.text(key: .todo_list_clear_button), for: .normal)
        return view
    }()
    
    private lazy var _allButton: TodoButton = {
        let view = TodoButton()
        view.setTitle(self._todoTextService.text(key: .todo_list_all_button), for: .normal)
        return view
    }()
    
    private lazy var _doneButton: TodoButton = {
        let view = TodoButton()
        view.setTitle(self._todoTextService.text(key: .todo_list_done_button), for: .normal)
        return view
    }()
    
    private lazy var _activeButton: TodoButton = {
        let view = TodoButton()
        view.setTitle(self._todoTextService.text(key: .todo_list_active_button), for: .normal)
        return view
    }()
    
    // MARK: - ViewController life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    override func setUpNavigationBar() {
        self.navigationItem.title = self._todoTextService.text(key: .todo_list_title)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        self._tableView.dataSource = self
        self._tableView.delegate = self
        self.view.addSubview(self._tableView)
        
        self._textField.borderStyle = .roundedRect
        self._textField.delegate = self
        self._textField.placeholder = self._todoTextService.text(key: .todo_list_text_field_placeholder)
        self.view.addSubview(self._textField)
        
        self.view.addSubview(self._filterLabel)
        self.view.addSubview(self._toggleAllButton)
        
        self._clearButton.isHidden = true
        self._clearButton.isActive = true
        self._clearButton.addTarget(self, action: #selector(didTapClearButton), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self._clearButton)
        
        self._toggleAllButton.isActive = true
        self._toggleAllButton.addTarget(self, action: #selector(didTapToggleAllButton), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self._toggleAllButton)
        
        self._allButton.isActive = true
        self._allButton.addTarget(self, action: #selector(didTapAllButton), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self._allButton)
        
        self._doneButton.isActive = false
        self._doneButton.addTarget(self, action: #selector(didTapDoneButton), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self._doneButton)
        
        self._activeButton.isActive = false
        self._activeButton.addTarget(self, action: #selector(didTapActiveButton), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self._activeButton)
    }
    
    override func setupLayout() {
        self._textField.snp.remakeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(50)
        }
        
        self._tableView.snp.remakeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self._textField.snp.bottom)
            make.bottom.equalTo(self._toggleAllButton.snp.top).offset(-20)
        }
        
        self._clearButton.snp.remakeConstraints { (make) in
            make.bottom.top.equalTo(self._toggleAllButton)
            make.height.equalTo(self._toggleAllButton)
            make.width.equalTo(self._allButton)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self._toggleAllButton.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self._allButton.snp.top).offset(-20)
            make.leading.equalTo(self._filterLabel)
            make.height.equalTo(self._allButton)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        self._filterLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        self._filterLabel.snp.remakeConstraints { (make) in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalTo(self._allButton)
        }
        
        self._allButton.snp.remakeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(45)
            make.leading.equalTo(self._filterLabel.snp.trailing).offset(20)
        }
        
        self._doneButton.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self._allButton)
            make.width.height.equalTo(self._allButton)
            make.leading.equalTo(self._allButton.snp.trailing).offset(20)
        }
        
        self._activeButton.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self._allButton)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(self._allButton)
            make.leading.equalTo(self._doneButton.snp.trailing).offset(20)
        }
    }
    
    // MARK: - IBActions
    
    @objc func didTapToggleAllButton() {
        self.presenter?.didTapToggleAllButton(with: self._filterType)
    }
    
    @objc func didTapClearButton() {
        self.presenter?.didTapClearButton(with: self._filterType)
    }
    
    @objc func didTapAllButton() {
        self._filterType = .All
        self.updateButtonActiveStates()
        self._tableView.reloadData()
    }
    
    @objc func didTapDoneButton() {
        self._filterType = .Done
        self.updateButtonActiveStates()
        self._tableView.reloadData()
    }
    
    @objc func didTapActiveButton() {
        self._filterType = .Active
        self.updateButtonActiveStates()
        self._tableView.reloadData()
    }
    
    private func updateButtonActiveStates() {
        self._allButton.isActive = self._filterType == .All ? true : false
        self._doneButton.isActive = self._filterType == .Done ? true : false
        self._activeButton.isActive = self._filterType == .Active ? true : false
        self.updateButtonHiddenStates()
    }
    
    private func updateButtonHiddenStates() {
        if self._filterType == .Done, let count = self.presenter?.getTodoListCount(with: self._filterType), count > 0 {
            self._clearButton.isHidden = false
        } else {
            self._clearButton.isHidden = true
        }
        
        if let count = self.presenter?.getTodoListCount(with: self._filterType), count > 0 {
            self._toggleAllButton.isHidden = false
        } else {
            self._toggleAllButton.isHidden = true
        }
    }
    
    private func presentPopup(title: String?, message: String?) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        popup.addAction(UIAlertAction(title: self._todoTextService.text(key: .todo_popup_ok_button), style: UIAlertAction.Style.cancel, handler: nil))
        self.present(popup, animated: true, completion: nil)
    }
}

extension TodoListViewController: TodoListPresenterOutputProtocol {
    
    func updateTodoList() {
        self.updateButtonHiddenStates()
        self._tableView.reloadData()
    }
    
    func scrollToTop() {
        if self._filterType == .Done {
            self.didTapAllButton()
        }
        let indexPath = IndexPath(row: 0, section: 0)
        self._tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
    func presentAddedSuccessPopup() {
        self.presentPopup(title: nil, message: self._todoTextService.text(key: .todo_popup_added_successfully))
    }
    
    func presentAddedErrorPopup() {
        self.presentPopup(title: nil, message: self._todoTextService.text(key: .todo_popup_adding_error))
    }
    
    func presentEnterEmptyNamePopup() {
        self.presentPopup(title: nil, message: self._todoTextService.text(key: .todo_popup_plese_enter_name_of_todo_item))
    }
    
    func presentDeleteItemPopup(with id: String) {
        let popup = UIAlertController(title: nil, message: self._todoTextService.text(key: .todo_popup_delete_item_message), preferredStyle: UIAlertController.Style.alert)
        popup.addAction(UIAlertAction(title: self._todoTextService.text(key: .todo_popup_cancel_button), style: .cancel, handler: nil))
        popup.addAction(UIAlertAction(title: self._todoTextService.text(key: .todo_popup_delete_button), style: .default, handler: { (action) in
            self.presenter?.didConfirmDeleteTodo(with: id)
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    func presentClearItemsPopup(with filter: FilterType) {
        let popup = UIAlertController(title: nil, message: self._todoTextService.text(key: .todo_popup_delete_item_list_message), preferredStyle: UIAlertController.Style.alert)
        popup.addAction(UIAlertAction(title: self._todoTextService.text(key: .todo_popup_cancel_button), style: .cancel, handler: nil))
        popup.addAction(UIAlertAction(title: self._todoTextService.text(key: .todo_popup_delete_button), style: .default, handler: { (action) in
            self.presenter?.didConfirmClearTodoList(with: filter)
        }))
        self.present(popup, animated: true, completion: nil)
    }
}

extension TodoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.presenter?.didEndEditing(with: textField.text)
        textField.text = ""
        return true
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getTodoListCount(with: self._filterType) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemViewCell.CELL_IDENTIFIER, for: indexPath) as? TodoItemViewCell else { return UITableViewCell() }
        
        guard let item = self.presenter?.getTodoItem(with: self._filterType, atIndex: indexPath.row) else { return cell }
        cell.delegate = self
        cell.configure(with: item)
        
        return cell
    }
}

extension TodoListViewController: UITableViewDelegate {
    // TODO: -
}

extension TodoListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self._textField.resignFirstResponder()
    }
}

extension TodoListViewController: TodoItemViewCellDelegate {
    func didTapCheckBox(at item: ViewModel_TodoItem) {
        self.presenter?.didTapCheckBox(with: item.id)
    }
    
    func didTapDeleteButton(at item: ViewModel_TodoItem) {
        self.presenter?.didTapDeleteButton(with: item.id)
    }
}
