import MapKit

class AnnotationView: MKAnnotationView {
    
    var lblTitle:UILabel!
    var lblSubtitle:UILabel!
    var divider:UIView!
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    func setup() {
        lblTitle = UILabel.init(frame:CGRect(x: 5, y: 3, width: 40, height: 20))
        lblSubtitle = UILabel.init(frame:CGRect(x: 5, y: 20, width: 40, height: 20))
        divider = UIView(frame: CGRect(x: 5, y: 20+2, width: 40, height: 1))
        divider.backgroundColor = .gray
        self.addSubview(divider)
        self.addSubview(lblTitle)
        self.addSubview(lblSubtitle)
    }
    
    
    func showTitle(title : String)
    {
        lblTitle.text = title
        lblTitle.textAlignment = .center
        lblSubtitle.font = UIFont.systemFont(ofSize: 15)
    }
    
    func showSubtitle(title : String)
    {
        lblSubtitle.text = title
        lblSubtitle.textAlignment = .center
        lblSubtitle.font = UIFont.systemFont(ofSize: 8)
    }
}
