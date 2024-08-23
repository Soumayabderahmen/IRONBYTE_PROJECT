package tn.ironbyte.ironbyteintern.services;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import tn.ironbyte.ironbyteintern.entities.User;
import tn.ironbyte.ironbyteintern.repositories.UserRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class UserServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserServiceImpl userService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetAllUsers() {
        User user1 = new User(1, "John Doe", "john.doe@example.com");
        User user2 = new User(2, "Jane Doe", "jane.doe@example.com");

        when(userRepository.findAll()).thenReturn(Arrays.asList(user1, user2));

        List<User> users = userService.getAllUsers();

        assertEquals(2, users.size());
        verify(userRepository, times(1)).findAll();
    }

    @Test
    void testCreateUser() {
        User user = new User(1, "John Doe", "john.doe@example.com");

        when(userRepository.save(any(User.class))).thenReturn(user);

        User createdUser = userService.createUser(user);

        assertNotNull(createdUser);
        assertEquals("John Doe", createdUser.getName());
        verify(userRepository, times(1)).save(user);
    }

    @Test
    void testUpdateUser() {
        User user = new User(1, "John Doe", "john.doe@example.com");

        when(userRepository.save(any(User.class))).thenReturn(user);

        User updatedUser = userService.updateUser(user);

        assertNotNull(updatedUser);
        assertEquals("John Doe", updatedUser.getName());
        verify(userRepository, times(1)).save(user);
    }

    @Test
    void testRemoveUser() {
        doNothing().when(userRepository).deleteById(1L);

        userService.removeUser(1L);

        verify(userRepository, times(1)).deleteById(1L);
    }
}