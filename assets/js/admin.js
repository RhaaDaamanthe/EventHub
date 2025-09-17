document.addEventListener('DOMContentLoaded', function() {
    // Sélection des éléments pour la liste des utilisateurs
    const toggleUsersBtn = document.getElementById('toggle-users');
    const userList = document.getElementById('user-list');

    // Sélection des éléments pour la liste des événements
    const toggleEventsBtn = document.getElementById('toggle-events');
    const eventList = document.getElementById('event-list');

    // Fonction de bascule générique
    const toggleList = (button, list) => {
        if (list.style.display === 'none') {
            list.style.display = 'block';
            button.textContent = 'Masquer la liste';
        } else {
            list.style.display = 'none';
            button.textContent = 'Afficher la liste';
        }
    };

    // Assure que les éléments existent
    if (toggleUsersBtn && userList && toggleEventsBtn && eventList) {
        // Cache les listes par défaut
        userList.style.display = 'none';
        eventList.style.display = 'none';

        // Ajoute les écouteurs d'événements
        toggleUsersBtn.addEventListener('click', () => toggleList(toggleUsersBtn, userList));
        toggleEventsBtn.addEventListener('click', () => toggleList(toggleEventsBtn, eventList));
    }
});