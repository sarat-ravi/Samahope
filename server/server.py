from selenium import webdriver
from selenium.webdriver.support.ui import Select
from flask import Flask
from flask import request
app = Flask("samahope")

states = ["Please Select", "Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming","Armed Forces (the) Americas","Armed Forces Europe","Armed Forces Pacific","American Samoa","Guam","Northern Mariana Islands","Puerto Rico","United States Minor Outlying Islands","Virgin Islands"]

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/donate")
def donate():
    return "Donation received"
    
    doc = request.args.get("doctor")
    interval = request.args.get("interval")
    amount = request.args.get("amount")
    first_name = request.args.get("firstName")
    last_name = request.args.get("lastName")
    email = request.args.get("email")
    card_number = request.args.get("cardNumber")
    security_code = request.args.get("securityCode")
    expiration_month = request.args.get("expirationMonth")
    expiration_year = request.args.get("expirationYear")
    address = request.args.get("address")
    city = request.args.get("city")
    state = request.args.get("state")
    zip_code = request.args.get("zip")

    print doc, interval, amount, first_name, last_name, email, card_number, expiration_month, expiration_year, address, city, state, zip_code

    browser = webdriver.Firefox()
    browser.get('https://www.samahope.org/donate/?doc=' + doc)

    if (interval == "once"):
        browser.find_elements_by_xpath("//label[@for='one-time']")[0].click()

    browser.find_elements_by_xpath("//label[@for='donate-custom']")[0].click()
    browser.find_element_by_id("custom-donation-amount").send_keys(amount)
    browser.find_elements_by_xpath("//a[@class='button donation-next-button']")[0].click()

    browser.find_elements_by_xpath("//input[@name='firstName']")[0].send_keys(first_name)
    browser.find_elements_by_xpath("//input[@name='lastName']")[0].send_keys(last_name)
    browser.find_elements_by_xpath("//input[@name='email']")[0].send_keys(email)

    # browser.find_elements_by_xpath("//input[@name='cardFirstName']")[0].send_keys(first_name)
    # browser.find_elements_by_xpath("//input[@name='cardLirstName']")[0].send_keys(last_name)
    
    browser.find_elements_by_xpath("//input[@name='cardNum']")[0].send_keys(card_number)
    Select(browser.find_elements_by_xpath("//select[@name='cardExpMonth']")[0]).select_by_visible_text(expiration_month)
    Select(browser.find_elements_by_xpath("//select[@name='cardExpYear']")[0]).select_by_visible_text(expiration_year)
    browser.find_elements_by_xpath("//input[@name='cardCode']")[0].send_keys(security_code)
    browser.find_elements_by_xpath("//input[@name='cardAddress']")[0].send_keys(address)

    browser.find_elements_by_xpath("//input[@name='cardCity']")[0].send_keys(city)

    stateIndex = states.index(state)
    print stateIndex
    browser.execute_script("document.getElementsByTagName('select')[9].selectedIndex=" + stateIndex)

    Select(browser.find_elements_by_xpath("//select[@name='cardState']")[0]).select_by_visible_text(state)
    
    browser.find_elements_by_xpath("//input[@name='cardZip']")[0].send_keys(zip_code)

    browser.find_elements_by_xpath("//button[@class='aqua']")[0].click()

    return "Donation page"

def main():
    print "hello"
    app.run()
    # my code here

if __name__ == "__main__":
    main()
