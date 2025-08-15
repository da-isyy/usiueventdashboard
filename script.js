// Event data
let events = JSON.parse(localStorage.getItem("events")) || [
  { name: "Hackathon 2025", date: "Aug 10-12", venue: "Auditorium", slots: 30 },
  { name: "Mental Health Talk", date: "Aug 30", venue: "TV Room 1", slots: 8 },
  { name: "Responsible AI: Ethics in Technology", date: "Aug 15", venue: "School of Science Rooftop", slots: 50 },
  { name: "Leadership in the Digital Age", date: "Aug 18", venue: "Main Auditorium", slots: 30 },
  { name: "Innovation Night: Student Showcase", date: "Aug 22", venue: "Incubation Center", slots: 20 },
  { name: "Understanding Addiction: A Modern Perspective", date: "Aug 25", venue: "LT8 (Humanities Building)", slots: 80 }
];

const tbody = document.getElementById("event-body");
const eventSelect = document.getElementById("event-select");
const form = document.getElementById("register-form");
const formMessage = document.getElementById("form-message");

// Render events in table
function renderEvents() {
  tbody.innerHTML = "";
  eventSelect.innerHTML = "";

  events.forEach((ev, i) => {
    let tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${ev.name}</td>
      <td>${ev.date}</td>
      <td>${ev.venue}</td>
      <td>${ev.slots}</td>
      <td><button ${ev.slots === 0 ? "disabled" : ""} onclick="bookSlot(${i})">
        ${ev.slots === 0 ? "Fully Booked" : "Register"}</button></td>
    `;
    tbody.appendChild(tr);

    if (ev.slots > 0) {
      let opt = document.createElement("option");
      opt.value = ev.name;
      opt.textContent = ev.name;
      eventSelect.appendChild(opt);
    }
  });

  localStorage.setItem("events", JSON.stringify(events));
}

// Book event slot
function bookSlot(index) {
  if (events[index].slots > 0) {
    events[index].slots--;
    alert(`Registered for ${events[index].name}`);
    renderEvents();
  }
}

// Form submission
form.addEventListener("submit", e => {
  e.preventDefault();
  const name = document.getElementById("name").value.trim();
  const studentId = document.getElementById("student-id").value.trim();
  const eventName = document.getElementById("event-select").value;

  if (!name || !studentId.match(/^USIU[0-9]{4}$/)) {
    formMessage.innerHTML = "<p style='color:red'>Fill all fields correctly!</p>";
    return;
  }

  formMessage.innerHTML = `<p style='color:green'>${name} (${studentId}) registered for ${eventName}</p>`;
});

renderEvents();
