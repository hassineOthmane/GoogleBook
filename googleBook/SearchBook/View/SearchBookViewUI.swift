//
//  SearchBookViewUI.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//
import UIKit

// MARK: SearchBookViewUI Delegate
protocol SearchBooksUIDelegate {
    func search(title:String,author:String)
    func showLibrary()
}

// MARK: SearchBookViewUI
class SearchBooksViewUI: UIView {

    var delegate: SearchBooksUIDelegate?

    let vStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 25
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    var title_txt : UITextField = {
        let txt = UITextField()
        txt.textColor = UIColor.white
        txt.textAlignment = .left
        txt.font = UIFont.init(name: "LucidaGrande", size: 16)
        txt.attributedPlaceholder = NSAttributedString(string: "title",attributes: [NSAttributedString.Key.foregroundColor: Colors.placeHolderColor])
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var author_txt : UITextField = {
        let txt = UITextField()
        txt.textAlignment = .left
        txt.attributedPlaceholder = NSAttributedString(string: "author",attributes: [NSAttributedString.Key.foregroundColor: Colors.placeHolderColor])
        txt.textColor = UIColor.white
        txt.font = UIFont.init(name: "LucidaGrande", size: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var search_btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors.accentColor
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.init(name: "LucidaGrande", size: 16)
        btn.setTitle("Search", for: UIControl.State.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()

    var library_btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors.accentColor
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.init(name: "LucidaGrande", size: 16)
        btn.setTitle("my library", for: UIControl.State.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }

    fileprivate func setupUIElements() {

        self.backgroundColor = Colors.backgroundColor
        // arrange subviews
        self.addSubview(vStackView)
        vStackView.addArrangedSubview(title_txt)
        vStackView.addArrangedSubview(author_txt)
        self.addSubview(search_btn)
        self.addSubview(library_btn)
        self.addLineToView(view: title_txt, position:.LINE_POSITION_BOTTOM, color: Colors.accentColor, width: 0.5)
        self.addLineToView(view: author_txt, position:.LINE_POSITION_BOTTOM, color: Colors.accentColor, width: 0.5)
        //Targets
        search_btn.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        library_btn.addTarget(self, action: #selector(libraryButtonClicked), for: .touchUpInside)
        hideKeyboard()
    }

    @objc func searchButtonClicked(sender : UIButton){
        delegate?.search(title: title_txt.text ?? "", author: author_txt.text ?? "")
    }

    @objc func libraryButtonClicked(sender : UIButton){
        delegate?.showLibrary()
    }

    fileprivate func setupConstraints() {

        var constraints = [NSLayoutConstraint]()
        // add constraints to subviews

        //MARK: vStackView
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 75)]  //vStackView.top = logo.top + 100
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 55)] //vStackView.leading = safeAreaLayoutGuide.leading + 55
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -55)] //vStackView.trailing = safeAreaLayoutGuide.trailing - 55

        //MARK: search_btn
        constraints += [NSLayoutConstraint.init(item: search_btn, attribute: .top, relatedBy: .equal, toItem: self.vStackView, attribute: .bottom, multiplier: 1.0, constant: 80)] //search.top = .vStackView + 80
        constraints += [NSLayoutConstraint.init(item: search_btn, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 55)] //search.leading = safeAreaLayoutGuide.leading + 55
        constraints += [NSLayoutConstraint.init(item: search_btn, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -55)] //search.trailing = safeAreaLayoutGuide.trailing - 55
        constraints += [NSLayoutConstraint.init(item: search_btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)] // search.height = 60


        //MARK: library_btn
        constraints += [NSLayoutConstraint.init(item: library_btn, attribute: .top, relatedBy: .equal, toItem: self.search_btn, attribute: .bottom, multiplier: 1.0, constant: 50)] //search.top = .search_btn + 50
        constraints += [NSLayoutConstraint.init(item: library_btn, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 55)] //library_btn.leading = safeAreaLayoutGuide.leading + 55
        constraints += [NSLayoutConstraint.init(item: library_btn, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -55)] //library_btn.trailing = safeAreaLayoutGuide.trailing - 55
        constraints += [NSLayoutConstraint.init(item: library_btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)] // library_btn.height = 60

        //MARK: title
        constraints += [NSLayoutConstraint.init(item: title_txt, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)] // title.height = 40

        //MARK: author
        constraints += [NSLayoutConstraint.init(item: author_txt, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)] // author.height = 40

        self.addConstraints(constraints)
    }

    func setLastValyes(title:String,author:String) -> Void {
        DispatchQueue.main.async {
            self.title_txt.text = title
            self.author_txt.text = author
        }
    }
}
