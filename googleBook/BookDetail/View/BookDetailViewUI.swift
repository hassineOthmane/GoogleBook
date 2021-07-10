//
//  BookDetailViewUI.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

class  BookDetailViewUI: UIView {

    var dataSource: BookDetailViewUIDataSource?

    var delegate: BookDetailViewUIDelegate?

    let vStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .center
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    var image_img : CustomImageView = {
        let img = CustomImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return img
    }()

    var title_lbl : UILabel = {
        let txt = UILabel()
        txt.textAlignment = .center
        txt.textColor = UIColor.white
        txt.numberOfLines = 0
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var author_lbl : UILabel = {
        let txt = UILabel()
        txt.textAlignment = .left
        txt.textColor = Colors.accentColor
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var preview_btn : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textAlignment = .left
        btn.setTitle("Preview", for:.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = Colors.accentColor
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.layer.cornerRadius = 15
        return btn
    }()

    var description_txt : UITextView = {
        let txt = UITextView()
        txt.textColor = UIColor.white
        txt.backgroundColor = Colors.backgroundColor
        txt.textAlignment = .justified
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.isEditable = false
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
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
        initTitle()
        initImage()
        initAuthor()
        initDescription()
    }

    @objc func pressed() {
        if let urlString = self.dataSource?.getBook()?.volumeInfo?.previewLink
        {
            self.delegate?.showUrlPage(url: urlString)
        }
    }

    fileprivate func setupUIElements() {
        DispatchQueue.main.async {
            self.backgroundColor = Colors.backgroundColor
            self.vStackView.addArrangedSubview(self.image_img)
            self.vStackView.addArrangedSubview(self.title_lbl)
            self.vStackView.addArrangedSubview(self.author_lbl)
            self.addSubview(self.vStackView)
            self.addSubview(self.description_txt)
            self.addSubview(self.preview_btn)
        }
    }

    func initTitle() -> Void {
        if let title = self.dataSource?.getBook()?.volumeInfo?.title
        {
            DispatchQueue.main.async {
                self.title_lbl.text = title
            }
        }
    }

    func initAuthor() -> Void {
        if let author = self.dataSource?.getBook()?.volumeInfo?.authors?.first
        {
            DispatchQueue.main.async {
                self.author_lbl.text = author
            }
        }
    }

    func initImage() -> Void {
        if let urlString = self.dataSource?.getBook()?.volumeInfo?.imageLinks?.smallThumbnail
        {

            DispatchQueue.main.async {
                self.image_img.loadImageList(urlString: urlString)
            }
        }
    }


    func initDescription() -> Void {
        if let description = self.dataSource?.getBook()?.volumeInfo?.description
        {

            DispatchQueue.main.async {
                self.description_txt.text = description
            }
        }
    }

    fileprivate func setupConstraints() {

        var constraints = [NSLayoutConstraint]()

        //MARK: image constraints
        constraints += [NSLayoutConstraint.init(item: image_img, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400)] //.height
        constraints += [NSLayoutConstraint.init(item: image_img, attribute: .width, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .width, multiplier: 1.0, constant: 0)] //.width

        //MARK: vStackView constraints
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0)] // vStackView.top = safeAreaLayoutGuide.top
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0)] // vStackView.leading = safeAreaLayoutGuide.leading
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0)] // vStackView.trailing = safeAreaLayoutGuide.trailing
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .bottom, relatedBy: .equal, toItem: self.description_txt, attribute: .top, multiplier: 1.0, constant: 0)] // vStackView.trailing = safeAreaLayoutGuide.trailing

        //MARK: descriptionTxt constraints
        constraints += [NSLayoutConstraint.init(item: description_txt, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0)] // descriptionTxt.leading = safeAreaLayoutGuide.leading
        constraints += [NSLayoutConstraint.init(item: description_txt, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0)] // descriptionTxt.trailing = safeAreaLayoutGuide.trailing
        constraints += [NSLayoutConstraint.init(item: description_txt, attribute: .bottom, relatedBy: .equal, toItem: preview_btn, attribute: .top, multiplier: 1.0, constant: 20)] // descriptionTxt.trailing = safeAreaLayoutGuide.trailing
        constraints += [NSLayoutConstraint.init(item: description_txt, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)] //.height

        
        //MARK: preview_btn constraints
        constraints += [NSLayoutConstraint.init(item: preview_btn, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20)] // preview_btn.leading = safeAreaLayoutGuide.leading
        constraints += [NSLayoutConstraint.init(item: preview_btn, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20)] // preview_btn.trailing = safeAreaLayoutGuide.trailing
        constraints += [NSLayoutConstraint.init(item: preview_btn, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -10)] // preview_btn.trailing = preview_btn.trailing
        constraints += [NSLayoutConstraint.init(item: preview_btn, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)] //.height

        DispatchQueue.main.async {
            self.addConstraints(constraints)
        }
    }
}

// MARK: BookDetailViewUI DataSource
protocol BookDetailViewUIDataSource {

    func getBook() -> BookModel?
}

// MARK: BookDetailViewUI Delegate -
protocol BookDetailViewUIDelegate {

    func showUrlPage(url:String)

}
