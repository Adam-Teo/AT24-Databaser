# The kivy app aka Window
from kivy.app import App 

# Widgets 
from kivy.uix.gridlayout import GridLayout 
#from kivy.uix.boxlayout import BoxLayout
#from kivy.uix.button import Button
from kivy.uix.textinput import TextInput
from kivy.uix.label import Label

class LoginScreen(GridLayout):
    def __init__(self, **kwargs): 
        super(LoginScreen, self).__init__(**kwargs)
        self.cols = 2
        self.add_widget(Label(text='User Name'))
        self.username = TextInput(multiline=False)
        self.add_widget(self.username)
        self.add_widget(Label(text='password'))
        self.password = TextInput(password=True, multiline=False)
        self.add_widget(self.password)

class sql_interface(App):
    def build(self):
        #textinput = TextInput(text="Enter Your Name: ")
        #textinput = "A"
        #return Label(text=f"Hello")
        #return TextInput(text="Enter Your Name: ")
        return LoginScreen()
# class HBoxLayout(App):
#     def build(self):
#         return Button()
    

if __name__ == "__main__":
    # print("Hello World")
    # app = HBoxLayout()
    app = sql_interface()
    app.run()
    


