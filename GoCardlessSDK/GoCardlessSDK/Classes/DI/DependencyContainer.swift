//
//  DependencyContainer.swift
//
//  Created by Gunhan Sancar on 06/04/2020.
//

/// Dependency module is used to register dependencies in a container
protocol DependencyModule {
    func register(_ container: DependencyContainer)
}

/// Factory is a function to create instances with given `DependencyContainer` and if needed with a `param`
typealias Factory<T> = (DependencyContainer, [Any?]) -> T

/// Scope of a dependency
enum DependencyScope {
    /// Single scope defines the dependency is created only once in the container
    case single
    /// Factory scope defines the dependency is created every time it is resolved for
    case factory
}

/// A dependency has a name, scope and a factory builder to create the instances when needed
struct Dependency<T> {
    let name: String
    let factory: Factory<T>
    let scope: DependencyScope
}

/// Dependency container is used to store all of the dependencies with given factories.
class DependencyContainer {
    private var dependencies: [String: Dependency<Any>] = [:]
    private var singleInstances: [String: Any] = [:]

    /// Registers a single scoped dependency
    func single<T>(name: String? = nil, _ type: T.Type, _ factory: @escaping Factory<T>) {
        register(name: name, type: type, scope: .single, factory)
    }

    /// Registers a factory scoped dependency
    func factory<T>(name: String? = nil, _ type: T.Type, _ factory: @escaping Factory<T>) {
        register(name: name, type: type, scope: .factory, factory)
    }

    /// Registers a dependency
    func register<T>(name: String? = nil, type: T.Type, scope: DependencyScope, _ factory: @escaping Factory<T>) {
        let name = name ?? String(describing: type)

        guard dependencies[name] == nil else {
            fatalError("You cannot register multiple dependencies using the same name (\(name)")
        }

        dependencies[name] = Dependency(name: name, factory: factory, scope: .factory)
    }

    /// Resolves a dependency from the container using the return type of `T` or using the `name` of the dependency
    /// By default the type of the dependency used as a name
    /// param - is the optional parameter to send to the construction of the resolved type
    func resolve<T>(_ name: String? = nil, param: Any?...) -> T {
        let name = name ?? String(describing: T.self)

        guard let dependency: Dependency = dependencies[name] else {
            fatalError("Dependency '\(name)' is not registered")
        }

        switch dependency.scope {
        case .single:
            if singleInstances[name] == nil {
                singleInstances[name] = dependency.factory(self, param)
            }
            guard let instance = singleInstances[name] as? T else {
                fatalError("Dependency '\(T.self)' has not found")
            }
            return instance
        case .factory:
            guard let instance = dependency.factory(self, param) as? T else {
                fatalError("Dependency '\(T.self)' has not found")
            }
            return instance
        }
    }

    deinit {
        dependencies.removeAll()
        singleInstances.removeAll()
    }
}
