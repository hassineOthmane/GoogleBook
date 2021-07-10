//
//  SearchBookViewUI.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//
import UIKit

// MARK: SearchBookViewUI Delegate -
/// SearchBookViewUI Delegate
protocol SearchBooksUIDelegate {
    func search(title:String,author:String)
}


class SearchBooksViewUI: UIView {

    var delegate: SearchBooksUIDelegate?


    // ui components

    let vStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 25
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    var title : UITextField = {
        let txt = UITextField()
        txt.textColor = UIColor.white
        txt.text = "misérables"
        txt.textAlignment = .left
        txt.font = UIFont.init(name: "LucidaGrande", size: 16)
        txt.attributedPlaceholder = NSAttributedString(string: "title",attributes: [NSAttributedString.Key.foregroundColor: Colors.placeHolderColor])
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var author : UITextField = {
        let txt = UITextField()
        txt.textAlignment = .left
        txt.text = "Hugo"
        txt.attributedPlaceholder = NSAttributedString(string: "author",attributes: [NSAttributedString.Key.foregroundColor: Colors.placeHolderColor])
        txt.textColor = UIColor.white
        txt.font = UIFont.init(name: "LucidaGrande", size: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var search : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors.accentColor
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.init(name: "LucidaGrande", size: 16)
        btn.setTitle("Search", for: UIControl.State.normal)
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
        vStackView.addArrangedSubview(title)
        vStackView.addArrangedSubview(author)
        self.addSubview(search)
        self.addLineToView(view: title, position:.LINE_POSITION_BOTTOM, color: Colors.accentColor, width: 0.5)
        self.addLineToView(view: author, position:.LINE_POSITION_BOTTOM, color: Colors.accentColor, width: 0.5)
        //Targets
        search.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        hideKeyboard()
    }

    @objc func buttonClicked(sender : UIButton){
        delegate?.search(title: title.text ?? "", author: author.text ?? "")
    }

    fileprivate func setupConstraints() {

        var constraints = [NSLayoutConstraint]()
        // add constraints to subviews



        //MARK: vStackView
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 75)]  //vStackView.top = logo.top + 100
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 55)] //vStackView.leading = safeAreaLayoutGuide.leading + 55
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -55)] //vStackView.trailing = safeAreaLayoutGuide.trailing - 55

        //MARK: search
        constraints += [NSLayoutConstraint.init(item: search, attribute: .top, relatedBy: .equal, toItem: self.vStackView, attribute: .bottom, multiplier: 1.0, constant: 80)] //search.top = .vStackView + 100
        constraints += [NSLayoutConstraint.init(item: search, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 55)] //search.leading = safeAreaLayoutGuide.leading + 55
        constraints += [NSLayoutConstraint.init(item: search, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -55)] //search.trailing = safeAreaLayoutGuide.trailing - 55
        constraints += [NSLayoutConstraint.init(item: search, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)] // search.height = 60

        //MARK: title
        constraints += [NSLayoutConstraint.init(item: title, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)] // title.height = 40

        //MARK: author
        constraints += [NSLayoutConstraint.init(item: author, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)] // author.height = 40

        self.addConstraints(constraints)
    }
}
