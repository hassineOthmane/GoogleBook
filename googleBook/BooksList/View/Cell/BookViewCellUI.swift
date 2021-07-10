//
//  BookViewCellUI.swift
//  googleBook
//
//  Created by hassine othmane on 7/10/21.
//

import UIKit

class BookViewCellUI : UIView {

    var containerView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = Colors.backgroundColorSecond
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var image : CustomImageView = {
        let img = CustomImageView()
        img.backgroundColor = UIColor.black.withAlphaComponent(0.11)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()

    let vStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.alignment = .leading
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    var title_lbl : UILabel = {
        let txt = UILabel()
        txt.textColor =  Colors.accentColor
        txt.textAlignment = .natural
        txt.numberOfLines = 1
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var author_lbl : UILabel = {
        let txt = UILabel()
        txt.textAlignment = .left
        txt.textColor = UIColor.white
        txt.numberOfLines = 1
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var description_lbl : UILabel = {
        let txt = UILabel()
        txt.textAlignment = .left
        txt.numberOfLines = 0
        txt.textColor = UIColor(red: 0.44, green: 0.43, blue: 0.48, alpha: 1.00)
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        DispatchQueue.main.async {
            self.containerView.layer.shouldRasterize = true
            self.containerView.layer.rasterizationScale = UIScreen.main.scale
            self.addSubview(self.containerView)
            self.containerView.addSubview(self.image)
            self.containerView.addSubview(self.vStackView)
            self.vStackView.addArrangedSubview(self.title_lbl)
            self.vStackView.addArrangedSubview(self.author_lbl)
            self.vStackView.addArrangedSubview(self.description_lbl)
            self.setupConstraints()
        }
    }

    fileprivate func setupConstraints() {
        var constraints = [NSLayoutConstraint]()

        //MARK: containerView constraints
        constraints += [NSLayoutConstraint.init(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)] // .top
        constraints += [NSLayoutConstraint.init(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)] //.leading
        constraints += [NSLayoutConstraint.init(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10)] // .bottom
        constraints += [NSLayoutConstraint.init(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30)] //.trailing

        //MARK: image constraints
        constraints += [NSLayoutConstraint.init(item: image, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0)] // .centerY
        constraints += [NSLayoutConstraint.init(item: image, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 5)] //.leading
        constraints += [NSLayoutConstraint.init(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 70)] //.width
        constraints += [NSLayoutConstraint.init(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 110)] //.height

        //MARK: title_lbl constraints
        constraints += [NSLayoutConstraint.init(item: title_lbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 17)] //.height

        //MARK: author_lbl constraints
        constraints += [NSLayoutConstraint.init(item: author_lbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 15)] //.height

        //MARK: vStackView constraints
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 5)]  //top
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .leading, relatedBy: .equal, toItem: self.image, attribute: .trailing, multiplier: 1.0, constant: 10)] //leading
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -5)] //trailing
        constraints += [NSLayoutConstraint.init(item: vStackView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -5)] //trailing


        self.addConstraints(constraints)
    }

}

extension BookViewCellUI
{

    func setTile(title:String) -> Void
    {
        DispatchQueue.main.async {
            self.title_lbl.text = title
        }
    }

    func setAuthor(author:String) -> Void
    {
        DispatchQueue.main.async {
            self.author_lbl.text = "\(author)"
        }
    }

    func setDescription(description:String) -> Void
    {
        DispatchQueue.main.async {
            self.description_lbl.text = "\(description)"
        }
    }


    func setImage(url:String) -> Void
    {
        image.loadImageList(urlString: url)
    }

}
