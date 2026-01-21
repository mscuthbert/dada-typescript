
start: PROLOGUE TITLE("What Reason did Myke have for submitting this receipt?") BODY excuses;

excuses: { num_excuses=3..10 } %repeat(main, num_excuses);

main: eventPhrase>upcase-first " " with " " people " " to " " verb " " adjective " " nebulous " " forPhrase "." PBRK;

addGreat(expression): "Great " expression;
eventPhrase: event | event " " at " " place | event " " at " " city | addGreat(event);
event: "coffee " | "lunch " | "drinks " | "dinner " | "meeting " | "conference ";
at: "at ";
city: "Boston" | "Rome" | "Cambridge" | "Paris" |
               "New York City" | "Florence";
place: "restaurant " | "hotel " | "MIT " | "restaurant in " city;
with: "with" | "with" | "including";
peoplePhrase: people | people | peopleNumber " " people;
people: "students" | "colleagues" | "co-workers" | "reporters";
peopleNumber: "two" | "three" | "four" | "five";
to: "to" | "to" | "to" | "to" | "in order to" | "in order to" | "for a purpose: to";
forPhrase: for " " adjective " " concrete;
for: "for";
verb: "plan" | "propose" | "create";
adjective: "medieval" | "new" | "digital" | "21st-century" | "engaging";
nebulous: "strategies" | "approaches" | "methods" | "methodologies";
to_for: to | for;
concrete: "transcriptions" | "editions" | "software" | "pedagogy" | "performances" | "humanities" | "musicology";
