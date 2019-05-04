import UIKit
import Foundation

func sessionLoadData(){
    //创建URL对象
    let urlString = "http://127.0.0.1:8000/"
    let url = URL(string:urlString)
    //创建请求对象
    let request = URLRequest(url: url!)
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request,
                                    completionHandler: {(data, response, error) -> Void in
                                        if error != nil{
                                            print(error.debugDescription)
                                        }else{
                                            let str = String(data: data!, encoding: String.Encoding.utf8)
                                            print(str!)
                                        }
    }) as URLSessionTask
    
    //使用resume方法启动任务
    dataTask.resume()
}
sessionLoadData()


