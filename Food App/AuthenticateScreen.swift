//
//  AuthenticateScreen.swift
//  Food App
//
//  Created by Nishain on 2/16/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import Firebase
class AuthenticateScreen: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    let firebaseAuth = Auth.auth()
    func getNextScreen()->UIViewController{
        let screen = self.storyboard!.instantiateViewController(identifier: LocationService().canConinue() ? "rootNavigator" : "locationRequest")
            screen.modalPresentationStyle = .fullScreen
            return screen
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let e = email.text!
        let p = password.text!
        firebaseAuth.signIn(withEmail: e, password: p, completion: {result,err in
            self.navigateToNextScreenIfSuccess(result:result,error:err)
        })
    }
    func navigateToNextScreenIfSuccess(result:Any?,error err:Any?){
        if(err != nil){
            print(err as Any)
        }else{
            let nextScreen = getNextScreen()
            nextScreen.modalPresentationStyle = .fullScreen
            self.present(nextScreen, animated: true, completion: nil)
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        let e = email.text!
        let p = password.text!
        print(e)
        firebaseAuth.createUser(withEmail: e, password: p, completion: { authResult,err in
            self.navigateToNextScreenIfSuccess(result: authResult, error: err)
    })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
