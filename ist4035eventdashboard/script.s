// Event Data
let events = JSON.parse(localStorage.getItem("events")) || [
    { name: "Hackathon 2025", date: "Aug 10-12", venue: "Auditorium", slots: 30 },
    { name: "Mental Health Talk", date: "Aug 30", venue: "TV Room 1", slots: 8 },
    { name: "Responsible AI: Ethics in Technology", date: "Aug 15", venue: "School of Science Rooftop", slots: 50 },
    { name: "Leadership in the Digital Age", date: "Aug 18", venue: "Main Auditorium", slots: 30 },
    { name: "Innovation Night: Student Showcase", date: "Aug 22", venue: "Incubation Center", slots: 20 },
    { name: "Understanding Addiction: A Modern Perspective", date: "Aug 25", venue: "LT8 (Humanities Building)", slots: 80 }
];

const eventGrid = document.getElementById("event-grid");
const eventSelect = document.getElementById("event-select");
const form = document.getElementById("register-form");
const formMessage = document.getElementById("form-message");

// Render Events
function renderEvents() {
    eventGrid.innerHTML = "";
    eventSelect.innerHTML = "";

    events.forEach((ev, index) => {
        // Card
        let card = document.createElement("div");
        card.className = "event-card";
        card.innerHTML = `
            <h3>${ev.name}</h3>
            <table>
                <tr><td><strong>Date:</strong></td><td>${ev.date}</td></tr>
                <tr><td><strong>Venue:</strong></td><td>${ev.venue}</td></tr>
                <tr><td><strong>Slots:</strong></td><td>${ev.slots}</td></tr>
                <tr><td colspan="2">
                    <button ${ev.slots === 0 ? "disabled" : ""} onclick="bookSlot(${index})">
                        ${ev.slots === 0 ? "Fully Booked" : "Register"}
                    </button>
                </td></tr>
            </table>
        `;
        eventGrid.appendChild(card);

        // Dropdown
        if (ev.slots > 0) {
            let option = document.createElement("option");
            option.value = ev.name;
            option.textContent = ev.name;
            eventSelect.appendChild(option);
        }
    });
    localStorage.setItem("events", JSON.stringify(events));
}

// Book slot
function bookSlot(index) {
    if (events[index].slots > 0) {
        events[index].slots--;
        alert(`You have successfully registered for ${events[index].name}`);
        renderEvents();
    }
}

// Handle form submission
form.addEventListener("submit", e => {
    e.preventDefault();
    const name = document.getElementById("name").value.trim();
    const studentId = document.getElementById("student-id").value.trim();
    const eventName = document.getElementById("event-select").value;

    if (!name || !studentId.match(/^USIU[0-9]{4}$/)) {
        formMessage.innerHTML = "<p style='color:red'>Please fill in all fields correctly.</p>";
        return;
    }

    formMessage.innerHTML = `<p style='color:green'>${name} (${studentId}) registered for ${eventName}</p>`;
});

renderEvents();
