//
//  ContentView.swift
//  RockPaperCesur
//
//  Created by administrator on 04/06/2021.
//

import SwiftUI

// Custom Modifier of Capsule Button

struct CapsuleStyle: ViewModifier{
	func body(content: Content) -> some View {
		content
			.frame(minWidth: 2, idealWidth: 70, maxWidth: 100, minHeight: 2, idealHeight: 20, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
			.clipShape(Capsule())
			.overlay(Capsule().stroke(Color.black, lineWidth: 2.0))
	}
}

extension View{
	func prettyButton() -> some View {
		self.modifier(CapsuleStyle())
	}
}


// Custom Button with Gradiant

struct GradiantButton: View {
	var buttonNum: Int
	var text: String
	var task: (Int) -> Void
	var body: some View{
		Button(action: {task(buttonNum)}){
			ZStack{
				LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
				Text("\(text)")
					.foregroundColor(.white)
			}
			.prettyButton()
			
		}
	}
}

// Main ContentView

struct ContentView: View {
	@State private var symbols = ["Rock", "Cesur", "Paper"]
	@State private var uncertainNum = Int.random(in: 0..<3)
	@State private var resultArray = ["Superior", "Inferior"]
	@State private var score = 0
	@State private var attempt = 0
    var body: some View {
		ZStack{
			LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea(.all)
			VStack{
				
				Group{
					Text("\(symbols[uncertainNum])")
						.fontWeight(.black)
					Text("\(resultArray[0]) to")
				}
				.foregroundColor(.white)
				.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
				.offset(x:0, y:-50)
				HStack{
					ForEach(0..<3){ num in
						GradiantButton(buttonNum: num, text: symbols[num], task: self.buttonPressed)
					}
				}
				HStack(spacing: 20){
					VStack{
						Text("Attempt")
							.fontWeight(.black)
						Text("\(attempt)")
					}
					.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
					.foregroundColor(.white)
					.offset(x:0, y:50)

					
					VStack{
						Text("Score")
							.fontWeight(.black)
						Text("\(score)")
					}
					.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
					.foregroundColor(.white)
					.offset(x:0, y:50)
					
				}
			}
		}
    }
	

	
	func buttonPressed(_ number: Int) -> Void{
		var result = false
		if self.resultArray[0] == "Inferior"{
			if self.symbols[number] == "Rock" && self.symbols[self.uncertainNum] == "Cesur"{
				result = true
			}
			else if self.symbols[number] == "Cesur" && self.symbols[self.uncertainNum] == "Paper"{
				result = true
			}
			else if self.symbols[number] == "Paper" && self.symbols[self.uncertainNum] == "Rock"{
				result = true
			}
		}
		else{
			if self.symbols[self.uncertainNum] == "Rock" && self.symbols[number] == "Cesur"{
				result = true
			}
			else if self.symbols[self.uncertainNum] == "Cesur" && self.symbols[number] == "Paper"{
				result = true
			}
			else if self.symbols[self.uncertainNum] == "Paper" && self.symbols[number] == "Rock"{
				result = true
			}
		}
		self.uncertainNum = Int.random(in: 0..<3)
		self.resultArray.shuffle()
		self.attempt += 1
		if result{
			self.score += 1
		}
		if self.attempt > 10{
			self.attempt = 0
			self.score = 0
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
