//
//  DataManager.swift
//  TasksAppRealm
//
//  Created by Владимир Макаров on 16.04.2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(_ completion: @escaping () -> Void) {
        
//        ПРоводим проверку. Если получилось вернуть из UserDefaults true по ключу "done", тогда if не сработает. В ином случае (при первом запуске приложения вернется false по ключу "done"), сработает if и в приложении загрузятся тестовые значения полей. Таким образом, загрузка тестовых значений будет производиться один раз при первом запуске.
        if !UserDefaults.standard.bool(forKey: "done") {
            
            UserDefaults.standard.set(true, forKey: "done")
//        Экземпляр модели TaskList
            let shoppingList = TaskList()
            shoppingList.name = "Shopping List"
            
            let moviesList = TaskList(value: ["Movies List", Date(), [["Best film ever"], ["The best of the best", "Must have", Date(), true]]])
            
//        Заполняем поля задач (первый способ)
            let milk = Task()
            milk.name = "Milk"
            milk.note = "2L"
       
//        Заполняем поля задач (второй способ). В этом способе необходимо проходиться по всем свойствам модели, перескакивать нельзя и важно соблюсти порядок как в модельке
            let bread = Task(value: ["Bread", "", Date(), true])
            
//            Заполняем поля задач (третий способ). Заполняем с помощью словаря. В этом случае, определяем тип ключа в словаре "name" и  "note" (ключ свойства модели) с типом String. И можем пропускать (не заполнять все поля свойств)
            let apples = Task(value: ["name": "Apples", "note": "2Kg"])
            
//        Добавили задачи в список (здесь показан первый способ добавления)
            shoppingList.tasks.append(milk)
            shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
            
//        Вызываем метод save для внесения изменений в базе данных. Вызов асинхронного потока необходим только для записи очень больших объемов данных. В данном случае показано как пример.
            DispatchQueue.main.async {
                StorageManager.shared.save(taskLists: [shoppingList, moviesList])
                completion()
            }
        }
    }
}

