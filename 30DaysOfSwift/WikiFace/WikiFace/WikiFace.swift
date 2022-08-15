//
//  WikiFace.swift
//  WikiFace
//
//  Created by 王亮 on 2022/8/15.
//

import ImageIO
import UIKit

class WikiFace: NSObject {
    enum WikiFaceError: Error {
        case CouldNotDownloadImage
    }

    class func faceForPerson(_ person: String, size: CGSize, completion: @escaping (_ image: UIImage?, _ imageFound: Bool) -> Void) throws {
        guard let escapedString = person.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {
            return
        }

        let pixelForAPIRequest = Int(max(size.width, size.height)) * 2

        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedString)&&prop=pageimages&format=json&pithumbsize=\(pixelForAPIRequest)") else {
            return
        }

        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data: Data?, _: URLResponse?, error: Error?) in
            if error != nil {
                completion(nil, false)
                return
            }

            guard let data = data else {
                completion(nil, false)
                return
            }

            guard let wikiDict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
                completion(nil, false)
                return
            }

            if let query = wikiDict.object(forKey: "query") as? NSDictionary,
               let pages = query.object(forKey: "pages") as? NSDictionary,
               let pageContent = pages.allValues.first as? NSDictionary,
               let thumbnail = pageContent.object(forKey: "thumbnail") as? NSDictionary,
               let thumbURL = thumbnail.object(forKey: "source") as? String,
               let imageData = try? Data(contentsOf: URL(string: thumbURL)!) {
                let faceImage = UIImage(data: imageData)
                completion(faceImage, true)

            } else {
                completion(nil, false)
            }

        })

        task.resume()
    }

    class func centerImageViewOnFace(_ imageView: UIImageView) {
        let context = CIContext(options: nil)
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options)

        guard let faceImage = imageView.image else {
            return
        }

        guard let cgImge = faceImage.cgImage else {
            return
        }

        if let features = detector?.features(in: CIImage(cgImage: cgImge)), features.count > 0 {

            if let faceFeature = features.first as? CIFaceFeature{
                var faceRectWithExtendedBounds = faceFeature.bounds
                faceRectWithExtendedBounds.origin.x -= 20
                faceRectWithExtendedBounds.origin.y -= 30

                faceRectWithExtendedBounds.size.width += 40
                faceRectWithExtendedBounds.size.height += 60

                let x = faceRectWithExtendedBounds.origin.x / faceImage.size.width
                let y = (faceImage.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage.size.height

                let widthFace = faceRectWithExtendedBounds.size.width / faceImage.size.width
                let heightFace = faceRectWithExtendedBounds.size.height / faceImage.size.height

                imageView.layer.contentsRect = CGRect(x: x, y: y, width: widthFace, height: heightFace)
            }
        }
    }
}
