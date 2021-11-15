//
//  ViewModel.swift
//  GridSearch
//
//  Created by Ivan Valero on 13/11/2021.
//

import Foundation





final class GridViewModel: ObservableObject {
    
    @Published var items = 0..<5
    @Published var results = [Result]()

    
    init() {
        // este inicializador simula la demora en la decodificacion de los datos en el archivo json
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
//            self.items = 0..<15
//        }
        
        
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                print(rss)
                DispatchQueue.main.async {
                    self.results = rss.feed.results
                }
                
            } catch {
                print("Error: \(error)")
            }
            
            
        }.resume()
        
        
        
        
    }
}
