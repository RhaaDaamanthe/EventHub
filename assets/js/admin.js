document.addEventListener('DOMContentLoaded', function() {
    const toggleBtn = document.getElementById('toggle-users');
    const userList = document.getElementById('user-list');
    
    // S'assure que les éléments existent
    if (toggleBtn && userList) {
        // La liste est cachée par défaut via le CSS
        toggleBtn.textContent = 'Afficher la liste';

        toggleBtn.addEventListener('click', function() {
            // Bascule la visibilité de la liste
            if (userList.style.display === 'none') {
                userList.style.display = 'block';
                toggleBtn.textContent = 'Masquer la liste';
            } else {
                userList.style.display = 'none';
                toggleBtn.textContent = 'Afficher la liste';
            }
        });
    }
});