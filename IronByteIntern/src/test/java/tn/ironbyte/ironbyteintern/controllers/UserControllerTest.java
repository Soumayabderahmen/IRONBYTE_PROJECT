package tn.ironbyte.ironbyteintern.controllers;

import static org.hamcrest.Matchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

// Importez explicitement any() de ArgumentMatchers
import static org.mockito.ArgumentMatchers.any;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import tn.ironbyte.ironbyteintern.entities.User;
import tn.ironbyte.ironbyteintern.services.IUserService;

import java.util.Arrays;
import java.util.List;

public class UserControllerTest {

    private MockMvc mockMvc;

    @Mock
    private IUserService userService;

    @InjectMocks
    private UserController userController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(userController).build();
    }

    @Test
    void testGetAllUsers() throws Exception {
        User user1 = new User(1, "John Doe", "john.doe@example.com");
        User user2 = new User(2, "Jane Doe", "jane.doe@example.com");
        List<User> userList = Arrays.asList(user1, user2);

        when(userService.getAllUsers()).thenReturn(userList);

        mockMvc.perform(get("/users/getAllUsers")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].name", is("John Doe")))
                .andExpect(jsonPath("$[1].name", is("Jane Doe")));

        verify(userService, times(1)).getAllUsers();
    }

    @Test
    void testCreateUser() throws Exception {
        User user = new User(1, "John Doe", "john.doe@example.com");
        when(userService.createUser(any(User.class))).thenReturn(user);

        mockMvc.perform(post("/users/add_User")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"name\":\"John Doe\", \"email\":\"john.doe@example.com\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name", is("John Doe")));

        verify(userService, times(1)).createUser(any(User.class));
    }

    @Test
    void testUpdateUser() throws Exception {
        User user = new User(1, "John Doe", "john.doe@example.com");
        when(userService.updateUser(any(User.class))).thenReturn(user);

        mockMvc.perform(put("/users/update_user")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"id\":1, \"name\":\"John Doe\", \"email\":\"john.doe@example.com\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name", is("John Doe")));

        verify(userService, times(1)).updateUser(any(User.class));
    }

    @Test
    void testRemoveUser() throws Exception {
        doNothing().when(userService).removeUser(1L);

        mockMvc.perform(delete("/users/del-user/1"))
                .andExpect(status().isOk());

        verify(userService, times(1)).removeUser(1L);
    }
}