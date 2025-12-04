import React, { createContext, useState, useContext, useEffect, ReactNode } from 'react';

interface LanguageContextType {
  language: string;
  setLanguage: (lang: string) => void;
  t: (key: string) => string;
}

const LanguageContext = createContext<LanguageContextType | undefined>(undefined);

// Diccionarios de idiomas
const translations = {
  es: {
    // Configuración
    'settings.title': 'Configuración',
    'settings.subtitle': 'Personaliza tu experiencia en Artiverse',
    'yourAccount': 'Tu Cuenta',
    'displayLanguage': 'Pantalla e Idiomas',
    'notifications': 'Notificaciones',
    'privacySecurity': 'Privacidad y Seguridad',
    'helpCenter': 'Centro de Ayuda',
    'logout': 'Cerrar Sesión',
    'saveChanges': 'Guardar Cambios',
    'saving': 'Guardando...',
    
    // Perfil
    'profile.edit': 'Editar Perfil',
    'profile.follow': 'Seguir',
    'profile.unfollow': 'Dejar de seguir',
    
    // General
    'home': 'Inicio',
    'search': 'Buscar',
    'messages': 'Mensajes',
    'categories': 'Categorías',
    'gallery': 'Galería de Arte',
    'back': 'Volver',
    'loading': 'Cargando...',
    'error': 'Error',
    'success': 'Éxito',
  },
  en: {
    // Settings
    'settings.title': 'Settings',
    'settings.subtitle': 'Customize your Artiverse experience',
    'yourAccount': 'Your Account',
    'displayLanguage': 'Display & Language',
    'notifications': 'Notifications',
    'privacySecurity': 'Privacy & Security',
    'helpCenter': 'Help Center',
    'logout': 'Log Out',
    'saveChanges': 'Save Changes',
    'saving': 'Saving...',
    
    // Profile
    'profile.edit': 'Edit Profile',
    'profile.follow': 'Follow',
    'profile.unfollow': 'Unfollow',
    
    // General
    'home': 'Home',
    'search': 'Search',
    'messages': 'Messages',
    'categories': 'Categories',
    'gallery': 'Art Gallery',
    'back': 'Back',
    'loading': 'Loading...',
    'error': 'Error',
    'success': 'Success',
  },
  fr: {
    // Configuration
    'settings.title': 'Paramètres',
    'settings.subtitle': 'Personnalisez votre expérience Artiverse',
    'yourAccount': 'Votre Compte',
    'displayLanguage': 'Affichage et Langue',
    'notifications': 'Notifications',
    'privacySecurity': 'Confidentialité et Sécurité',
    'helpCenter': 'Centre d\'Aide',
    'logout': 'Déconnexion',
    'saveChanges': 'Enregistrer les modifications',
    'saving': 'Enregistrement...',
    
    // Profile
    'profile.edit': 'Modifier le profil',
    'profile.follow': 'Suivre',
    'profile.unfollow': 'Ne plus suivre',
    
    // Général
    'home': 'Accueil',
    'search': 'Rechercher',
    'messages': 'Messages',
    'categories': 'Catégories',
    'gallery': 'Galerie d\'Art',
    'back': 'Retour',
    'loading': 'Chargement...',
    'error': 'Erreur',
    'success': 'Succès',
  },
};

interface LanguageProviderProps {
  children: ReactNode;
}

export const LanguageProvider: React.FC<LanguageProviderProps> = ({ children }) => {
  const [language, setLanguageState] = useState<string>(() => {
    // Recuperar idioma guardado del localStorage
    return localStorage.getItem('appLanguage') || 'es';
  });

  const setLanguage = (lang: string) => {
    setLanguageState(lang);
    localStorage.setItem('appLanguage', lang);
    
    // También puedes guardar en el servidor si el usuario está logueado
    const usuario = localStorage.getItem('usuario');
    if (usuario) {
      try {
        // Opcional: Guardar preferencia en el backend
        fetch('http://localhost:8000/api/preferencias/idioma', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'token': localStorage.getItem('token') || '',
          },
          body: JSON.stringify({ idioma: lang }),
        });
      } catch (error) {
        console.error('Error guardando preferencia de idioma:', error);
      }
    }
  };

  // Función de traducción
  const t = (key: string): string => {
    const langDict = translations[language as keyof typeof translations] || translations.es;
    return langDict[key as keyof typeof langDict] || key;
  };

  // Efecto para aplicar el idioma al HTML
  useEffect(() => {
    document.documentElement.lang = language;
    document.documentElement.setAttribute('data-language', language);
    
    // También podrías cambiar el título de la página
    document.title = t('settings.title') + ' - Artiverse';
  }, [language]);

  return (
    <LanguageContext.Provider value={{ language, setLanguage, t }}>
      {children}
    </LanguageContext.Provider>
  );
};

// Hook personalizado para usar el contexto
export const useLanguage = (): LanguageContextType => {
  const context = useContext(LanguageContext);
  if (!context) {
    throw new Error('useLanguage debe ser usado dentro de LanguageProvider');
  }
  return context;
};