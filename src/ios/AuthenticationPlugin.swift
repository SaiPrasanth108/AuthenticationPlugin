import LocalAuthentication
import UIKit

@objc(AuthenticationPlugin) 
class AuthenticationPlugin : CDVPlugin{
    
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    
    @objc(authenticateFaceIdOrTouchId:) 
    func authenticateFaceIdOrTouchId(_ command: CDVInvokedUrlCommand) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, authenticationEror) in
                DispatchQueue.main.async {
                    if success {
                        print("success")
                        self?.pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "success")
                    } else {
                        print("error")
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.viewController.present(ac, animated: true)
                        self?.pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Authentication failed")
                    }
                }
            }
        } else {
            print("no biometric")
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(ac, animated: true)
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Biometry unavailable")
        }
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }
}
