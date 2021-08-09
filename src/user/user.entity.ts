import { objectType } from "nexus";
import { User } from 'nexus-prisma';

/// Define a User entity.
export const UserEntity = objectType({
    name: User.$name,
    description: User.$description,
    definition(t) {
        t.field(User.id);
        t.field(User.name);
        t.field(User.email);
        t.field(User.mobile);
        t.field(User.password);
        t.field(User.registeredAt);
    },
});
