//
//  ViewController.swift
//  27HWUITextField
//
//  Created by Сергей on 07.01.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

//Итак начинаем текстовые поля. Напоминаю, этот элемент очень распространен и не очень простой, поэтому уделите ему должное внимание. Начнем с простого, а после урока номер 28 я добавлю задания уровней повыше.
//
//Создаем форму для регистрации студента.
//
//Ученик.
//
//✅1. Создайте поля (и лейблы напротив как в уроке): имя, фамилия, логин, пароль, возраст, телефон, имеил адрес.
//✅2. Установите правильные виды клавиатур для каждого текстового поля.
//✅3. У всех текстовых полей кроме последнего кнопка ретерн должна быть NEXT, а у последнего DONE.
//✅4. Осуществите переход по кнопкам NEXT и уберите клаву с экрана кнопкой DONE.
//✅5. Каждое поле при нажатии должно иметь кнопку очистки
//
//Студент
//
//✅6. Совет, чтобы осуществить переход по NEXT без проверки тонны пропертей, попробуйте использовать UIOutletCollection
//✅7. Создайте соответствующие каждому текстовому полю UILabel чтобы выводить туда информацию из текстовых полей. Сделайте их мелкими и другого цвета.
//✅8. По изменению текста (даже буквы) обновляйте эти лейблы (не забудте про CLEAR button)d
//
//✅Мастер
//
//✅9. Для поля ввода телефона используйте мой код из видео, можете поместить его в какой-то оотдельный метод если надо
//✅10. Этот код должен работать только для поля телефона и не для какого другого
//
//✅Супермен
//
//✅11. Для поля ввода имеила ограничте ввод символов недопустимых в адресе
//✅12. Более того, сибвол "@" может быть введен только 1 раз
//✅13. установите разумное ограничение для этого поля

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Outlet
    @IBOutlet weak var clearAllButton: UIButton!
    
    //MARK: Propertys
    
    let indentElementsByVertical: CGFloat = 30.0
    let indentElementsByHorizontal: CGFloat = 200.0
    let widthElement: CGFloat = 200.0
    let heightElement: CGFloat = 30.0
    
    let nameLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 400, height: 60))
    let lastNameLabel = UILabel(frame: CGRect(x: 100, y: 180, width: 400, height: 60))
    let loginLabel = UILabel(frame: CGRect(x: 100, y: 260, width: 400, height: 60))
    let passwordLabel = UILabel(frame: CGRect(x: 100, y: 340, width: 400, height: 60))
    let ageLabel = UILabel(frame: CGRect(x: 100, y: 420, width: 400, height: 60))
    let numberPhoneLabel = UILabel(frame: CGRect(x: 100, y: 500, width: 400, height: 60))
    let emailLabel = UILabel(frame: CGRect(x: 100, y: 580, width: 400, height: 60))
    
    let nameTextField = UITextField(frame: CGRect(x: 600, y: 100, width: 400, height: 60))
    let lastNameTextField = UITextField(frame: CGRect(x: 600, y: 180, width: 400, height: 60))
    let loginTextField = UITextField(frame: CGRect(x: 600, y: 260, width: 400, height: 60))
    let passwordTextField = UITextField(frame: CGRect(x: 600, y: 340, width: 400, height: 60))
    let ageTextField = UITextField(frame: CGRect(x: 600, y: 420, width: 400, height: 60))
    let numberPhoneTextField = UITextField(frame: CGRect(x: 600, y: 500, width: 400, height: 60))
    let emailTextField = UITextField(frame: CGRect(x: 600, y: 580, width: 400, height: 60))
    
    var collectionTextFields = [UITextField]()
    var collectionLabels = [UILabel]()
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startSettings()
        
    }
    
    //MARK: IBAction
    @IBAction func clearAllTextFieldsActionButton(sender: UIButton) {
        
        for i in 0..<self.collectionTextFields.count {
            self.collectionTextFields[i].text = ""
            self.collectionLabels[i].text = ""
        }
        
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn textField.text = \(textField.text ?? "")")
        
        let currentIndexTF = self.collectionTextFields.firstIndex(of: textField) ?? 0
        let lastTF = self.collectionTextFields.last ?? UITextField()
        
        if textField.isEqual(lastTF) {
            textField.resignFirstResponder()
        } else {
            self.collectionTextFields[currentIndexTF + 1].becomeFirstResponder()
        }
        
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
    
        let currentIndexTF = self.collectionTextFields.firstIndex(of: textField) ?? 0

        self.collectionLabels[currentIndexTF].text = textField.text
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case let textF where textF.isEqual(self.ageTextField):
            return self.formatingAge(in: textField, range: range, replacementString: string)
        case let textF where textF.isEqual(self.numberPhoneTextField):
            return self.formatingNumber(in: textField, range: range, replacementString: string)
        case let textF where textF.isEqual(self.emailTextField):
            return self.formatingEmail(in: textField, range: range, replacementString: string)
        case let textF where textF.isEqual(self.nameTextField):
            fallthrough
        case let textF where textF.isEqual(self.lastNameTextField):
            return self.formatingName(in: textField, range: range, replacementString: string)
        case let textF where textF.isEqual(self.loginTextField):
            fallthrough
        case let textF where textF.isEqual(self.passwordTextField):
            return self.formatingLogin(in: textField, range: range, replacementString: string)
        default: return false
        }
    
    }
        
    //REMARK: Help methods
    
    private func startSettings() {
        
            self.view.backgroundColor = .black
            self.clearAllButton.layer.cornerRadius = 10
        
            self.collectionTextFields.append(self.nameTextField)
            self.collectionTextFields.append(self.lastNameTextField)
            self.collectionTextFields.append(self.loginTextField)
            self.collectionTextFields.append(self.passwordTextField)
            self.collectionTextFields.append(self.ageTextField)
            self.collectionTextFields.append(self.numberPhoneTextField)
            self.collectionTextFields.append(self.emailTextField)
            
            self.collectionLabels.append(self.nameLabel)
            self.collectionLabels.append(self.lastNameLabel)
            self.collectionLabels.append(self.loginLabel)
            self.collectionLabels.append(self.passwordLabel)
            self.collectionLabels.append(self.ageLabel)
            self.collectionLabels.append(self.numberPhoneLabel)
            self.collectionLabels.append(self.emailLabel)
            
            for i in 0..<self.collectionLabels.count {
                
                self.view.addSubview(self.collectionLabels[i])
                self.view.addSubview(self.collectionTextFields[i])
                
                self.collectionLabels[i].textAlignment = .center
                self.collectionLabels[i].backgroundColor = .yellow
                self.collectionLabels[i].font = self.collectionLabels[i].font.withSize(30.0)
                
                self.collectionTextFields[i].borderStyle = .roundedRect
                self.collectionTextFields[i].backgroundColor = .orange
                self.collectionTextFields[i].font = self.collectionTextFields[i].font?.withSize(30.0)
                
            }
        
            self.nameTextField.textAlignment = .center
            self.nameTextField.clearButtonMode = .whileEditing
            self.nameTextField.keyboardType = .namePhonePad
            self.nameTextField.autocapitalizationType = .words
            self.nameTextField.autocorrectionType = .yes
            self.nameTextField.smartInsertDeleteType = .yes
            self.nameTextField.spellCheckingType = .yes
            self.nameTextField.keyboardAppearance = .dark
            self.nameTextField.returnKeyType = .next
            self.nameTextField.placeholder = "Enter Name"
            self.nameTextField.delegate = self
            
            self.lastNameTextField.textAlignment = .center
            self.lastNameTextField.clearButtonMode = .whileEditing
            self.lastNameTextField.keyboardType = .namePhonePad
            self.lastNameTextField.autocapitalizationType = .words
            self.lastNameTextField.autocorrectionType = .yes
            self.lastNameTextField.smartInsertDeleteType = .yes
            self.lastNameTextField.spellCheckingType = .yes
            self.lastNameTextField.keyboardAppearance = .dark
            self.lastNameTextField.returnKeyType = .next
            self.lastNameTextField.placeholder = "Enter Last Name"
            self.lastNameTextField.delegate = self
            
            self.loginTextField.textAlignment = .center
            self.loginTextField.clearButtonMode = .whileEditing
            self.loginTextField.keyboardType = .namePhonePad
            self.loginTextField.autocapitalizationType = .words
            self.loginTextField.autocorrectionType = .yes
            self.loginTextField.smartInsertDeleteType = .yes
            self.loginTextField.spellCheckingType = .yes
            self.loginTextField.keyboardAppearance = .dark
            self.loginTextField.returnKeyType = .next
            self.loginTextField.placeholder = "Enter Login"
            self.loginTextField.delegate = self
            
            self.passwordTextField.textAlignment = .center
            self.passwordTextField.clearButtonMode = .whileEditing
            self.passwordTextField.keyboardType = .default
            self.passwordTextField.autocapitalizationType = .words
            self.passwordTextField.autocorrectionType = .yes
            self.passwordTextField.smartInsertDeleteType = .yes
            self.passwordTextField.spellCheckingType = .yes
            self.passwordTextField.keyboardAppearance = .dark
            self.passwordTextField.returnKeyType = .next
            self.passwordTextField.isSecureTextEntry = true
            self.passwordTextField.placeholder = "Entry Password"
            self.passwordTextField.delegate = self
            
            self.ageTextField.textAlignment = .center
            self.ageTextField.clearButtonMode = .whileEditing
            self.ageTextField.keyboardType = .numberPad
            self.ageTextField.autocapitalizationType = .words
            self.ageTextField.autocorrectionType = .yes
            self.ageTextField.smartInsertDeleteType = .yes
            self.ageTextField.spellCheckingType = .yes
            self.ageTextField.keyboardAppearance = .dark
            self.ageTextField.returnKeyType = .next
            self.ageTextField.placeholder = "Enter Age"
            self.ageTextField.delegate = self
            
            self.numberPhoneTextField.textAlignment = .center
            self.numberPhoneTextField.clearButtonMode = .whileEditing
            self.numberPhoneTextField.keyboardType = .numberPad
            self.numberPhoneTextField.autocapitalizationType = .words
            self.numberPhoneTextField.autocorrectionType = .yes
            self.numberPhoneTextField.smartInsertDeleteType = .yes
            self.numberPhoneTextField.spellCheckingType = .yes
            self.numberPhoneTextField.keyboardAppearance = .dark
            self.numberPhoneTextField.returnKeyType = .next
            self.numberPhoneTextField.placeholder = "Enter Phone Number"
            self.numberPhoneTextField.delegate = self
            
            self.emailTextField.textAlignment = .center
            self.emailTextField.keyboardType = .emailAddress
            self.emailTextField.keyboardAppearance = .dark
            self.emailTextField.returnKeyType = .done
            self.emailTextField.clearButtonMode = .whileEditing
            self.emailTextField.placeholder = "Enter Email"
            self.emailTextField.delegate = self
        
    }
    
    
    //MARK: Formating Number
    
    private func formatingNumber(in textField: UITextField, range: NSRange, replacementString str: String) -> Bool {
        
        let indexOfDash = 3
        let indexZero = 0
        
        var newStrFromTF: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: str) as NSString
        
        let resultStr: NSMutableString = ""
        
        let validationSet = CharacterSet.decimalDigits.inverted
        
        let components = str.components(separatedBy: validationSet)
        
        if components.count > 1 {
            return false
        }
        
        let localNumberMaxLength = 7
        let areaCodeMaxLength = 3
        let countryCodeMaxLenght = 3
        
        let validComponents = newStrFromTF.components(separatedBy: validationSet)
        newStrFromTF = validComponents.joined() as NSString
       
        guard newStrFromTF.length <= (localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLenght) else { return false}
        
        let localNumberLength = min(newStrFromTF.length, localNumberMaxLength)
        
        if localNumberLength > indexZero {

            let number = newStrFromTF.substring(with: NSRange(location: newStrFromTF.length - localNumberLength, length: localNumberLength))
            resultStr.append(number)
            
            if resultStr.length > indexOfDash {
                resultStr.insert("-", at: indexOfDash)
            }

        }
        
        if newStrFromTF.length > localNumberMaxLength {

            let areaCodeLength = min(newStrFromTF.length - localNumberMaxLength, areaCodeMaxLength)
            var area = newStrFromTF.substring(with: NSRange(location: newStrFromTF.length - localNumberMaxLength - areaCodeLength, length: areaCodeLength))
            area = String(format: " (%@) ", area)
            
            resultStr.insert(area, at: indexZero)
            
        }
        
        if newStrFromTF.length > (localNumberMaxLength + areaCodeMaxLength) {
            
            let countryCodeLength = min(newStrFromTF.length - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLenght)
            var country = newStrFromTF.substring(with: NSRange(location: newStrFromTF.length - localNumberLength -                                                             areaCodeMaxLength - countryCodeLength,
                                                                 length: countryCodeLength))
            country = String(format: "+%@", country)
            
            resultStr.insert(country, at: indexZero)
            
        }
        
        textField.text = resultStr as String
 
    return false
    }
      
    //MARK: Formating Age
    
    private func formatingAge(in textField: UITextField, range: NSRange, replacementString str: String) -> Bool {
        
        let ageMaxLength = 2
        
        let validSet = CharacterSet.decimalDigits.inverted
        
        let components = str.components(separatedBy: validSet)
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: str)
       
        guard components.count < 2 && newString.count <= ageMaxLength else { return false }
        
        textField.text = newString
        
    return false
    }
    
    //MARK: Formating Email
    
    private func formatingEmail(in textField: UITextField, range: NSRange, replacementString str: String) -> Bool {
        
        let maxLengthSimbol = 20
        
        let allowSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ@1234567890._-").inverted
        let validComponents = str.components(separatedBy: allowSet)
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: str)
        
        if validComponents.count > 1 || newString.count >= maxLengthSimbol {
            return false
        }
        
        let text = textField.text ?? ""
        
        if text.contains("@") && str == "@" {
                return false
            }
        
        textField.text = newString
        
        return false
        }

    //MARK: Formating Name and Last Name
    
    private func formatingName(in textField: UITextField, range: NSRange, replacementString str: String) -> Bool {

        let maxLengthSimbol = 20
        let validSet = CharacterSet.letters.inverted
        let components = str.components(separatedBy: validSet)
        
        let text = (textField.text ?? "") as NSString
        let newString = text.replacingCharacters(in: range, with: str) as NSString
        
        guard components.count < 2 && newString.length <= maxLengthSimbol else { return false }
        
        textField.text = newString as String
    return false
    }
   
    //MARK: Formating Login and password
    
    private func formatingLogin(in textField: UITextField, range: NSRange, replacementString str: String) -> Bool {
    
    let maxLengthSimbol = 20
    
        let validSet = CharacterSet.decimalDigits.union(CharacterSet.letters).inverted
        
        let text = (textField.text ?? "") as NSString
        let newString = text.replacingCharacters(in: range, with: str)
        
        let components = str.components(separatedBy: validSet)
        
        guard components.count < 2 && newString.count <= maxLengthSimbol else { return false }
        
        textField.text = newString
        
    return false
    }
}



