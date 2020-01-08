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
//✅8. По изменению текста (даже буквы) обновляйте эти лейблы (не забудте про CLEAR button)
//
//Мастер
//
//9. Для поля ввода телефона используйте мой код из видео, можете поместить его в какой-то оотдельный метод если надо
//10. Этот код должен работать только для поля телефона и не для какого другого
//
//Супермен
//
//11. Для поля ввода имеила ограничте ввод символов недопустимых в адресе
//12. Более того, сибвол "@" может быть введен только 1 раз
//13. установите разумное ограничение для этого поля

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    let indentElementsByVertical: CGFloat = 30.0
    let indentElementsByHorizontal: CGFloat = 200.0
    let widthElement: CGFloat = 200.0
    let heightElement: CGFloat = 30.0
    //w - 100 - wtf
    
    let nameLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 60))
    let lastNameLabel = UILabel(frame: CGRect(x: 100, y: 180, width: 300, height: 60))
    let loginLabel = UILabel(frame: CGRect(x: 100, y: 260, width: 300, height: 60))
    let passwordLabel = UILabel(frame: CGRect(x: 100, y: 340, width: 300, height: 60))
    let ageLabel = UILabel(frame: CGRect(x: 100, y: 420, width: 300, height: 60))
    let numberPhoneLabel = UILabel(frame: CGRect(x: 100, y: 500, width: 300, height: 60))
    let emailLabel = UILabel(frame: CGRect(x: 100, y: 580, width: 300, height: 60))
    
    let nameTextField = UITextField(frame: CGRect(x: 624, y: 100, width: 300, height: 60))
    let lastNameTextField = UITextField(frame: CGRect(x: 624, y: 180, width: 300, height: 60))
    let loginTextField = UITextField(frame: CGRect(x: 624, y: 260, width: 300, height: 60))
    let passwordTextField = UITextField(frame: CGRect(x: 624, y: 340, width: 300, height: 60))
    let ageTextField = UITextField(frame: CGRect(x: 624, y: 420, width: 300, height: 60))
    let numberPhoneTextField = UITextField(frame: CGRect(x: 624, y: 500, width: 300, height: 60))
    let emailTextField = UITextField(frame: CGRect(x: 624, y: 580, width: 300, height: 60))
    
    var collectionTextFields = [UITextField]()
    var collectionLabels = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        let sizeScreen = UIScreen.main.bounds
        print("sizeScreen.width = \(sizeScreen.width)")
        
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
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing textField.text = \(textField.text ?? "")")
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing textField.text = \(textField.text ?? "")")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn textField.text = \(textField.text ?? "")")
        
        for i in 0..<self.collectionTextFields.count {

            if textField.isEqual(self.collectionTextFields[i]) && (i + 1) < self.collectionTextFields.count {
                self.collectionTextFields[i + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            
        }
    
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("textFieldDidEndEditing textField.text = \(textField.text ?? "")")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear textField.text = \(textField.text ?? "")")
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection textField.text = \(textField.text ?? "")")
        
        for i in 0..<self.collectionTextFields.count {
            
            if self.collectionTextFields[i].isEqual(textField) {
                
                self.collectionLabels[i].text = textField.text
                
            }
            
        }
        
    }
    
    //если символ содержится в сете тогда тру
    //еслс символ @ и он не содержится в тексте текст филда тогда тру
    //если поступивший символ - @ и текст уже содержит дог тогда лож
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) textField.text = \(textField.text ?? ""), string = \(string)")
        
        guard self.emailTextField.isEqual(textField) else { return true }
        
        let allowSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ@1234567890._-")

    
        
        
        if (textField.text?.contains("@") ?? false) && string == "@" {
            return false
        } else if allowSet.contains(Unicode.Scalar(string) ?? "🥀") {
            return true
        }
        
        if textField.text!.isEmpty && textField.text!.count < 16 {
            return true
        }

           return false
      }
        
        
        
    }



