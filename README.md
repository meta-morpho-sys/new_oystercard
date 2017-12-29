# Oystercard

During the solution of this challenge I used the following technologies:
Testing: Rspec, Simplecov

### Steps
I started off by developing a single class - the Oystercard class only. Then proceeded by separating responsibilities and delegating them to other classes. 

Currently I have a Station, a JourneyLog, a Journey, and Billing classes. JourneyLog is for internal, private use of Oystercard. JourneyLog Uses a Journey class to starts a journey and uses the Billing class to calculate the fares. The interface is displayed in the Oystercard diagram.

